"""
Core computational taxonomy utilities.

Run:
    python python/taxonomy_core.py
"""

from __future__ import annotations

import math
from typing import Iterable

import numpy as np


def validate_unit_interval(values: Iterable[float], label: str) -> None:
    arr = np.asarray(list(values), dtype=float)
    if np.any((arr < 0) | (arr > 1)):
        raise ValueError(f"{label} must be between 0 and 1.")


def p_distance(seq1: str, seq2: str) -> float:
    """Calculate uncorrected p-distance for aligned sequences."""

    if len(seq1) != len(seq2):
        raise ValueError("Sequences must be aligned and equal length.")
    if len(seq1) == 0:
        raise ValueError("Sequences must not be empty.")

    differences = sum(a != b for a, b in zip(seq1.upper(), seq2.upper()))
    return differences / len(seq1)


def jukes_cantor_distance(p: float) -> float:
    """Calculate Jukes-Cantor corrected distance."""

    if p < 0:
        raise ValueError("p-distance must be non-negative.")
    if p >= 0.75:
        return math.nan

    return -0.75 * math.log(1 - (4.0 / 3.0) * p)


def shannon_diversity(counts: Iterable[float]) -> float:
    """Calculate Shannon diversity from non-negative counts."""

    arr = np.asarray(list(counts), dtype=float)
    if np.any(arr < 0):
        raise ValueError("Counts must be non-negative.")
    total = arr.sum()
    if total <= 0:
        raise ValueError("Total abundance must be positive.")

    p = arr[arr > 0] / total
    return float(-np.sum(p * np.log(p)))


def bray_curtis(x: Iterable[float], y: Iterable[float]) -> float:
    """Calculate Bray-Curtis dissimilarity."""

    x_arr = np.asarray(list(x), dtype=float)
    y_arr = np.asarray(list(y), dtype=float)

    if len(x_arr) != len(y_arr):
        raise ValueError("Vectors must have equal length.")
    if np.any(x_arr < 0) or np.any(y_arr < 0):
        raise ValueError("Abundances must be non-negative.")

    denominator = x_arr.sum() + y_arr.sum()
    if denominator <= 0:
        raise ValueError("Combined abundance must be positive.")

    return float(1 - (2 * np.minimum(x_arr, y_arr).sum()) / denominator)


def taxonomic_confidence_score(
    sequence_similarity: float,
    morphological_support: float,
    geographic_plausibility: float,
    phylogenetic_support: float,
    uncertainty_penalty: float,
) -> float:
    """Calculate transparent taxonomic assignment-confidence score."""

    validate_unit_interval(
        [
            sequence_similarity,
            morphological_support,
            geographic_plausibility,
            phylogenetic_support,
            uncertainty_penalty,
        ],
        "confidence inputs",
    )

    return (
        0.30 * sequence_similarity
        + 0.20 * morphological_support
        + 0.15 * geographic_plausibility
        + 0.25 * phylogenetic_support
        - 0.10 * uncertainty_penalty
    )


def main() -> None:
    """Run smoke-test outputs."""

    p = p_distance("ATGCTAGCTAAC", "ATGCTAGCTATC")
    print("p_distance=", round(p, 6))
    print("jukes_cantor=", round(jukes_cantor_distance(p), 6))
    print("shannon=", round(shannon_diversity([25, 18, 11, 6]), 6))
    print("bray_curtis=", round(bray_curtis([25, 18, 11, 6], [10, 24, 15, 12]), 6))
    print("confidence=", round(taxonomic_confidence_score(0.98, 0.90, 0.88, 0.94, 0.05), 6))


if __name__ == "__main__":
    main()
