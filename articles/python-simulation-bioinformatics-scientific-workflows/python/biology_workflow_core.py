"""
Core utilities for Python-based biological simulation, sequence analysis,
metadata validation, and workflow provenance.
"""

from __future__ import annotations

from collections import Counter
from pathlib import Path
import hashlib
import math
import random

import pandas as pd


VALID_DNA_BASES = {"A", "C", "G", "T"}


def simulate_logistic_growth(
    initial_population: float,
    growth_rate: float,
    carrying_capacity: float,
    dt: float,
    steps: int,
    scenario: str = "scenario",
) -> pd.DataFrame:
    """Simulate deterministic logistic growth using Euler approximation."""
    if initial_population < 0:
        raise ValueError("initial_population must be non-negative.")
    if carrying_capacity <= 0:
        raise ValueError("carrying_capacity must be positive.")
    if dt <= 0:
        raise ValueError("dt must be positive.")
    if steps < 0:
        raise ValueError("steps must be non-negative.")

    population = float(initial_population)
    rows: list[dict[str, float | int | str]] = []

    for step in range(steps + 1):
        time = step * dt
        rows.append(
            {
                "scenario": scenario,
                "step": step,
                "time": time,
                "population": population,
            }
        )

        growth = growth_rate * population * (1 - population / carrying_capacity)
        population = max(population + dt * growth, 0.0)

    return pd.DataFrame(rows)


def simulate_stochastic_growth(
    initial_population: float,
    growth_rate: float,
    carrying_capacity: float,
    dt: float,
    steps: int,
    noise_sd: float,
    random_seed: int,
    scenario: str = "stochastic_scenario",
) -> pd.DataFrame:
    """Simulate stochastic logistic growth with additive Gaussian process noise."""
    if noise_sd < 0:
        raise ValueError("noise_sd must be non-negative.")

    rng = random.Random(random_seed)
    population = float(initial_population)
    rows: list[dict[str, float | int | str]] = []

    for step in range(steps + 1):
        time = step * dt
        rows.append(
            {
                "scenario": scenario,
                "step": step,
                "time": time,
                "population": population,
            }
        )

        deterministic_growth = dt * growth_rate * population * (1 - population / carrying_capacity)
        stochastic_noise = rng.gauss(0.0, noise_sd)
        population = max(population + deterministic_growth + stochastic_noise, 0.0)

    return pd.DataFrame(rows)


def parse_fasta_text(fasta_text: str) -> dict[str, str]:
    """Parse a small FASTA-formatted string into sequence records."""
    records: dict[str, str] = {}
    current_id: str | None = None
    current_sequence: list[str] = []

    for line in fasta_text.strip().splitlines():
        line = line.strip()

        if not line:
            continue

        if line.startswith(">"):
            if current_id is not None:
                records[current_id] = "".join(current_sequence).upper()
            current_id = line[1:].split()[0]
            current_sequence = []
        else:
            current_sequence.append(line)

    if current_id is not None:
        records[current_id] = "".join(current_sequence).upper()

    if len(records) == 0:
        raise ValueError("No FASTA records were parsed.")

    return records


def parse_fasta_file(path: Path) -> dict[str, str]:
    """Read and parse a FASTA file."""
    return parse_fasta_text(path.read_text())


def gc_content(sequence: str) -> float:
    """Calculate GC content from valid A/C/G/T bases only."""
    sequence = sequence.upper()
    valid_bases = [base for base in sequence if base in VALID_DNA_BASES]

    if not valid_bases:
        return math.nan

    counts = Counter(valid_bases)
    return (counts["G"] + counts["C"]) / len(valid_bases)


def count_ambiguous_bases(sequence: str) -> int:
    """Count non-A/C/G/T characters in a sequence."""
    return sum(base not in VALID_DNA_BASES for base in sequence.upper())


def count_kmers(sequence: str, k: int) -> Counter[str]:
    """Count valid DNA k-mers."""
    if k <= 0:
        raise ValueError("k must be positive.")

    sequence = sequence.upper()
    counts: Counter[str] = Counter()

    for i in range(len(sequence) - k + 1):
        kmer = sequence[i : i + k]
        if set(kmer).issubset(VALID_DNA_BASES):
            counts[kmer] += 1

    return counts


def summarize_sequences(records: dict[str, str]) -> pd.DataFrame:
    """Create a sequence-level summary table."""
    rows = []

    for sequence_id, sequence in records.items():
        rows.append(
            {
                "sequence_id": sequence_id,
                "length": len(sequence),
                "gc_content": gc_content(sequence),
                "ambiguous_bases": count_ambiguous_bases(sequence),
            }
        )

    return pd.DataFrame(rows)


def sha256_file(path: Path) -> str:
    """Calculate SHA-256 checksum for a file."""
    digest = hashlib.sha256()

    with path.open("rb") as handle:
        for block in iter(lambda: handle.read(65536), b""):
            digest.update(block)

    return digest.hexdigest()


def validate_metadata(metadata: pd.DataFrame, sequence_ids: set[str]) -> pd.DataFrame:
    """Validate sequence metadata against expected columns and FASTA identifiers."""
    required_columns = {"sequence_id", "organism", "condition", "batch", "qc_flag"}
    valid_qc_flags = {"pass", "review", "fail"}

    missing_columns = sorted(required_columns - set(metadata.columns))
    invalid_qc_flags = sorted(set(metadata["qc_flag"].dropna()) - valid_qc_flags) if "qc_flag" in metadata else []
    metadata_ids = set(metadata["sequence_id"]) if "sequence_id" in metadata else set()

    checks = [
        {
            "check": "required_columns",
            "passed": len(missing_columns) == 0,
            "details": "none" if not missing_columns else ", ".join(missing_columns),
        },
        {
            "check": "unique_sequence_ids",
            "passed": metadata["sequence_id"].is_unique if "sequence_id" in metadata else False,
            "details": "unique" if "sequence_id" in metadata and metadata["sequence_id"].is_unique else "duplicates or missing column",
        },
        {
            "check": "valid_qc_flags",
            "passed": len(invalid_qc_flags) == 0,
            "details": "none" if not invalid_qc_flags else ", ".join(invalid_qc_flags),
        },
        {
            "check": "metadata_matches_fasta",
            "passed": metadata_ids == sequence_ids,
            "details": "matched" if metadata_ids == sequence_ids else f"metadata_only={sorted(metadata_ids - sequence_ids)}; fasta_only={sorted(sequence_ids - metadata_ids)}",
        },
    ]

    return pd.DataFrame(checks)
