"""
Core utilities for genomics, sequence analysis, and biological data workflows.
"""

from __future__ import annotations

from collections import Counter
from pathlib import Path
import hashlib
import math

import pandas as pd


VALID_DNA = {"A", "C", "G", "T"}
STOP_CODONS = {"TAA", "TAG", "TGA"}

CODON_TABLE = {
    "TTT": "F", "TTC": "F", "TTA": "L", "TTG": "L",
    "TCT": "S", "TCC": "S", "TCA": "S", "TCG": "S",
    "TAT": "Y", "TAC": "Y", "TAA": "*", "TAG": "*",
    "TGT": "C", "TGC": "C", "TGA": "*", "TGG": "W",
    "CTT": "L", "CTC": "L", "CTA": "L", "CTG": "L",
    "CCT": "P", "CCC": "P", "CCA": "P", "CCG": "P",
    "CAT": "H", "CAC": "H", "CAA": "Q", "CAG": "Q",
    "CGT": "R", "CGC": "R", "CGA": "R", "CGG": "R",
    "ATT": "I", "ATC": "I", "ATA": "I", "ATG": "M",
    "ACT": "T", "ACC": "T", "ACA": "T", "ACG": "T",
    "AAT": "N", "AAC": "N", "AAA": "K", "AAG": "K",
    "AGT": "S", "AGC": "S", "AGA": "R", "AGG": "R",
    "GTT": "V", "GTC": "V", "GTA": "V", "GTG": "V",
    "GCT": "A", "GCC": "A", "GCA": "A", "GCG": "A",
    "GAT": "D", "GAC": "D", "GAA": "E", "GAG": "E",
    "GGT": "G", "GGC": "G", "GGA": "G", "GGG": "G",
}


def parse_fasta_text(fasta_text: str) -> dict[str, str]:
    """Parse FASTA-formatted text into a dictionary of sequence records."""
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
    """Calculate GC content from valid A/C/G/T bases."""
    valid_bases = [base for base in sequence.upper() if base in VALID_DNA]

    if len(valid_bases) == 0:
        return math.nan

    counts = Counter(valid_bases)
    return (counts["G"] + counts["C"]) / len(valid_bases)


def ambiguous_base_count(sequence: str) -> int:
    """Count non-A/C/G/T characters."""
    return sum(base not in VALID_DNA for base in sequence.upper())


def summarize_sequences(records: dict[str, str]) -> pd.DataFrame:
    """Create a sequence-level summary table."""
    rows = []

    for sequence_id, sequence in records.items():
        rows.append(
            {
                "sequence_id": sequence_id,
                "length": len(sequence),
                "valid_dna_bases": sum(base in VALID_DNA for base in sequence.upper()),
                "ambiguous_bases": ambiguous_base_count(sequence),
                "gc_content": gc_content(sequence),
            }
        )

    return pd.DataFrame(rows)


def count_kmers(sequence: str, k: int) -> Counter[str]:
    """Count valid DNA k-mers."""
    if k <= 0:
        raise ValueError("k must be positive.")

    sequence = sequence.upper()
    counts: Counter[str] = Counter()

    for start in range(len(sequence) - k + 1):
        kmer = sequence[start : start + k]
        if set(kmer).issubset(VALID_DNA):
            counts[kmer] += 1

    return counts


def find_simple_orfs(sequence: str, minimum_codons: int = 3) -> list[dict[str, int | str]]:
    """Find simple ATG-to-stop ORFs on the forward strand."""
    sequence = sequence.upper()
    orfs: list[dict[str, int | str]] = []

    for frame in range(3):
        start = None

        for position in range(frame, len(sequence) - 2, 3):
            codon = sequence[position : position + 3]

            if codon == "ATG" and start is None:
                start = position

            if codon in STOP_CODONS and start is not None:
                codon_count = (position + 3 - start) // 3

                if codon_count >= minimum_codons:
                    orfs.append(
                        {
                            "frame": frame,
                            "start": start,
                            "end": position + 3,
                            "codons": codon_count,
                            "stop_codon": codon,
                        }
                    )

                start = None

    return orfs


def translate_dna(sequence: str) -> str:
    """Translate a DNA sequence using a compact standard codon table."""
    sequence = sequence.upper()
    amino_acids = []

    for position in range(0, len(sequence) - 2, 3):
        codon = sequence[position : position + 3]
        amino_acids.append(CODON_TABLE.get(codon, "X"))

    return "".join(amino_acids)


def parse_fastq_text(fastq_text: str) -> list[dict[str, str]]:
    """Parse a small FASTQ-formatted string."""
    lines = [line.strip() for line in fastq_text.strip().splitlines() if line.strip()]

    if len(lines) % 4 != 0:
        raise ValueError("FASTQ text must contain groups of four lines.")

    records = []

    for index in range(0, len(lines), 4):
        header, sequence, plus, quality = lines[index : index + 4]

        if not header.startswith("@") or plus != "+":
            raise ValueError("Invalid FASTQ record structure.")
        if len(sequence) != len(quality):
            raise ValueError("FASTQ sequence and quality strings must have equal length.")

        records.append(
            {
                "read_id": header[1:].split()[0],
                "sequence": sequence.upper(),
                "quality": quality,
            }
        )

    return records


def phred_scores(quality: str) -> list[int]:
    """Convert FASTQ Phred+33 quality string to scores."""
    return [ord(character) - 33 for character in quality]


def summarize_fastq(records: list[dict[str, str]]) -> pd.DataFrame:
    """Create a read-level FASTQ quality summary."""
    rows = []

    for record in records:
        scores = phred_scores(record["quality"])
        rows.append(
            {
                "read_id": record["read_id"],
                "read_length": len(record["sequence"]),
                "mean_phred": sum(scores) / len(scores),
                "min_phred": min(scores),
                "ambiguous_bases": ambiguous_base_count(record["sequence"]),
                "gc_content": gc_content(record["sequence"]),
            }
        )

    return pd.DataFrame(rows)


def validate_variants(variants: pd.DataFrame, minimum_depth: int = 10) -> pd.DataFrame:
    """Validate a compact single-nucleotide variant table."""
    result = variants.copy()
    result["valid_ref_alt"] = result.apply(
        lambda row: row["reference"] in VALID_DNA and row["alternate"] in VALID_DNA,
        axis=1,
    )
    result["positive_position"] = result["position"] > 0
    result["alternate_depth_valid"] = result["alternate_depth"] <= result["read_depth"]
    result["passes_depth_threshold"] = result["read_depth"] >= minimum_depth
    result["variant_allele_frequency"] = result["alternate_depth"] / result["read_depth"]
    result["passes_basic_validation"] = (
        result["valid_ref_alt"]
        & result["positive_position"]
        & result["alternate_depth_valid"]
        & result["passes_depth_threshold"]
    )
    return result


def validate_metadata(metadata: pd.DataFrame, sequence_ids: set[str]) -> pd.DataFrame:
    """Validate sequence metadata against FASTA identifiers."""
    required_columns = {"sequence_id", "organism", "source", "condition", "batch", "qc_flag"}
    valid_qc_flags = {"pass", "review", "fail"}

    missing = sorted(required_columns - set(metadata.columns))
    metadata_ids = set(metadata["sequence_id"]) if "sequence_id" in metadata else set()
    invalid_qc = sorted(set(metadata["qc_flag"].dropna()) - valid_qc_flags) if "qc_flag" in metadata else []

    return pd.DataFrame(
        [
            {
                "check": "required_columns",
                "passed": len(missing) == 0,
                "details": "none" if not missing else ", ".join(missing),
            },
            {
                "check": "unique_sequence_ids",
                "passed": metadata["sequence_id"].is_unique if "sequence_id" in metadata else False,
                "details": "unique" if "sequence_id" in metadata and metadata["sequence_id"].is_unique else "duplicates or missing column",
            },
            {
                "check": "valid_qc_flags",
                "passed": len(invalid_qc) == 0,
                "details": "none" if not invalid_qc else ", ".join(invalid_qc),
            },
            {
                "check": "metadata_matches_fasta",
                "passed": metadata_ids == sequence_ids,
                "details": "matched" if metadata_ids == sequence_ids else f"metadata_only={sorted(metadata_ids - sequence_ids)}; fasta_only={sorted(sequence_ids - metadata_ids)}",
            },
        ]
    )


def sha256_file(path: Path) -> str:
    """Calculate SHA-256 checksum for a file."""
    digest = hashlib.sha256()

    with path.open("rb") as handle:
        for block in iter(lambda: handle.read(65536), b""):
            digest.update(block)

    return digest.hexdigest()


def safe_sha256(path: Path) -> str:
    """Return a checksum or not-available marker."""
    if path.exists() and path.is_file():
        return sha256_file(path)
    return "not_available"
