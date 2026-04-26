"""
Core quantitative utilities for the rise of modern biological thought.

Run:
    python python/modern_biology_core.py
"""

from __future__ import annotations

from dataclasses import dataclass
import math
from typing import Iterable

import numpy as np


@dataclass(frozen=True)
class GrowthFit:
    growth_rate: float
    initial_population: float
    doubling_time: float
    r_squared_log_space: float


def fit_exponential_growth(time: np.ndarray, population: np.ndarray) -> GrowthFit:
    """Fit log-linear exponential growth."""

    if len(time) != len(population):
        raise ValueError("time and population must have equal length.")
    if len(time) < 3:
        raise ValueError("At least three observations are recommended.")
    if np.any(time < 0):
        raise ValueError("time must be non-negative.")
    if np.any(population <= 0):
        raise ValueError("population must be positive.")

    slope, intercept = np.polyfit(time, np.log(population), 1)
    fitted = intercept + slope * time
    observed = np.log(population)

    ss_res = np.sum((observed - fitted) ** 2)
    ss_tot = np.sum((observed - np.mean(observed)) ** 2)
    r_squared = 1 - ss_res / ss_tot if ss_tot > 0 else math.nan

    return GrowthFit(
        growth_rate=float(slope),
        initial_population=float(math.exp(intercept)),
        doubling_time=float(math.log(2) / slope if slope > 0 else math.nan),
        r_squared_log_space=float(r_squared),
    )


def logistic_growth(time: np.ndarray, initial_population: float, growth_rate: float, carrying_capacity: float) -> np.ndarray:
    """Calculate logistic growth trajectory."""

    if initial_population <= 0:
        raise ValueError("initial_population must be positive.")
    if carrying_capacity <= initial_population:
        raise ValueError("carrying_capacity must exceed initial_population.")
    if growth_rate < 0:
        raise ValueError("growth_rate must be non-negative.")
    if np.any(time < 0):
        raise ValueError("time must be non-negative.")

    return carrying_capacity / (
        1 + ((carrying_capacity - initial_population) / initial_population) * np.exp(-growth_rate * time)
    )


def hardy_weinberg(p: float) -> dict[str, float]:
    """Return Hardy-Weinberg genotype expectations."""

    if p < 0 or p > 1:
        raise ValueError("Allele frequency p must be between 0 and 1.")

    q = 1 - p

    return {
        "AA": p**2,
        "Aa": 2 * p * q,
        "aa": q**2,
    }


def mean_fitness(p: float, w_aa_capital: float, w_heterozygote: float, w_aa_lower: float) -> float:
    """Calculate mean fitness for a two-allele diploid model."""

    q = 1 - p
    return p**2 * w_aa_capital + 2 * p * q * w_heterozygote + q**2 * w_aa_lower


def selection_update(p: float, w_AA: float, w_Aa: float, w_aa: float) -> float:
    """Update allele frequency p under viability selection."""

    if p < 0 or p > 1:
        raise ValueError("Allele frequency p must be between 0 and 1.")
    if min(w_AA, w_Aa, w_aa) < 0:
        raise ValueError("Fitness values must be non-negative.")

    q = 1 - p
    wbar = mean_fitness(p, w_AA, w_Aa, w_aa)

    if wbar <= 0:
        raise ValueError("Mean fitness must be positive.")

    return (p**2 * w_AA + p * q * w_Aa) / wbar


def sequence_similarity(seq1: str, seq2: str) -> float:
    """Calculate simple aligned sequence similarity."""

    if len(seq1) != len(seq2):
        raise ValueError("Sequences must be aligned and equal length.")
    if len(seq1) == 0:
        raise ValueError("Sequences must not be empty.")

    differences = sum(a != b for a, b in zip(seq1.upper(), seq2.upper()))
    return 1 - differences / len(seq1)


def main() -> None:
    time = np.array([0, 2, 4, 6, 8, 10], dtype=float)
    population = np.array([100, 148, 219, 324, 479, 708], dtype=float)

    print(fit_exponential_growth(time, population))
    print(hardy_weinberg(0.7))
    print("selection_update=", round(selection_update(0.5, 1.1, 1.05, 1.0), 6))
    print("sequence_similarity=", round(sequence_similarity("ATGCTAGCTAAC", "ATGCTAGCTATC"), 6))


if __name__ == "__main__":
    main()
