"""
Core biological-methods utilities.

Run:
    python python/biological_methods_core.py
"""

from __future__ import annotations

from dataclasses import dataclass
import math
from typing import Iterable

import numpy as np


@dataclass(frozen=True)
class GrowthFit:
    growth_rate: float
    initial_abundance: float
    doubling_time: float
    r_squared_log_space: float


@dataclass(frozen=True)
class AssayMetrics:
    sensitivity: float
    specificity: float
    positive_predictive_value: float
    negative_predictive_value: float
    accuracy: float


def fit_exponential_growth(time: np.ndarray, abundance: np.ndarray) -> GrowthFit:
    """Fit log-linear exponential growth."""

    if len(time) != len(abundance):
        raise ValueError("time and abundance must have equal length.")
    if len(time) < 3:
        raise ValueError("At least three observations are recommended.")
    if np.any(time < 0):
        raise ValueError("time must be non-negative.")
    if np.any(abundance <= 0):
        raise ValueError("abundance must be positive.")

    slope, intercept = np.polyfit(time, np.log(abundance), 1)
    fitted = intercept + slope * time
    observed = np.log(abundance)

    ss_res = np.sum((observed - fitted) ** 2)
    ss_tot = np.sum((observed - np.mean(observed)) ** 2)
    r_squared = 1 - ss_res / ss_tot if ss_tot > 0 else math.nan

    return GrowthFit(
        growth_rate=float(slope),
        initial_abundance=float(math.exp(intercept)),
        doubling_time=float(math.log(2) / slope if slope > 0 else math.nan),
        r_squared_log_space=float(r_squared),
    )


def logistic_growth(time: np.ndarray, initial_abundance: float, growth_rate: float, carrying_capacity: float) -> np.ndarray:
    """Calculate logistic growth trajectory."""

    if initial_abundance <= 0:
        raise ValueError("initial_abundance must be positive.")
    if carrying_capacity <= initial_abundance:
        raise ValueError("carrying_capacity must exceed initial abundance.")
    if growth_rate < 0:
        raise ValueError("growth_rate must be non-negative.")

    return carrying_capacity / (
        1 + ((carrying_capacity - initial_abundance) / initial_abundance) * np.exp(-growth_rate * time)
    )


def hill_response(concentration: np.ndarray, emin: float, emax: float, ec50: float, hill: float) -> np.ndarray:
    """Calculate Hill dose-response."""

    if ec50 <= 0:
        raise ValueError("ec50 must be positive.")
    if hill <= 0:
        raise ValueError("hill coefficient must be positive.")
    if np.any(concentration <= 0):
        raise ValueError("concentrations must be positive.")

    return emin + (emax - emin) / (1 + (ec50 / concentration) ** hill)


def assay_metrics(tp: int, fn: int, tn: int, fp: int) -> AssayMetrics:
    """Calculate common assay validation metrics."""

    if min(tp, fn, tn, fp) < 0:
        raise ValueError("Assay counts must be non-negative.")

    sensitivity = tp / (tp + fn) if (tp + fn) > 0 else math.nan
    specificity = tn / (tn + fp) if (tn + fp) > 0 else math.nan
    ppv = tp / (tp + fp) if (tp + fp) > 0 else math.nan
    npv = tn / (tn + fn) if (tn + fn) > 0 else math.nan
    accuracy = (tp + tn) / (tp + tn + fp + fn) if (tp + tn + fp + fn) > 0 else math.nan

    return AssayMetrics(sensitivity, specificity, ppv, npv, accuracy)


def hamming_distance(seq1: str, seq2: str) -> int:
    """Calculate Hamming distance for aligned sequences."""

    if len(seq1) != len(seq2):
        raise ValueError("Sequences must be aligned and equal length.")

    return sum(a != b for a, b in zip(seq1.upper(), seq2.upper()))


def signal_quality_score(signal_strength: float, reproducibility: float, control_separation: float, noise_penalty: float) -> float:
    """Calculate transparent experimental signal-quality score."""

    values = [signal_strength, reproducibility, control_separation, noise_penalty]
    if any(v < 0 or v > 1 for v in values):
        raise ValueError("Signal-score inputs must be between 0 and 1.")

    return (
        0.30 * signal_strength
        + 0.30 * reproducibility
        + 0.25 * control_separation
        - 0.15 * noise_penalty
    )


def main() -> None:
    time = np.array([0, 2, 4, 6, 8, 10], dtype=float)
    cells = np.array([1.0e5, 1.6e5, 2.7e5, 4.3e5, 6.8e5, 1.0e6], dtype=float)

    print(fit_exponential_growth(time, cells))
    print(assay_metrics(84, 16, 91, 9))
    print("hamming_distance=", hamming_distance("ATGCTAGCTAAC", "ATGCTAGCTATC"))
    print("signal_quality=", round(signal_quality_score(0.86, 0.82, 0.78, 0.14), 6))


if __name__ == "__main__":
    main()
