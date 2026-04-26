"""
Core metabolism models and validation utilities.

Run:
    python python/metabolism_core.py
"""

from __future__ import annotations

from dataclasses import dataclass
import math
from typing import Iterable

import numpy as np


@dataclass(frozen=True)
class GrowthFit:
    """Container for exponential growth-fit outputs."""

    growth_rate_per_h: float
    initial_abundance: float
    doubling_time_h: float
    r_squared_log_space: float


def validate_positive(values: Iterable[float], label: str) -> None:
    """Raise ValueError if any value is non-positive."""

    arr = np.asarray(list(values), dtype=float)
    if np.any(~np.isfinite(arr)):
        raise ValueError(f"{label} contains non-finite values.")
    if np.any(arr <= 0):
        raise ValueError(f"{label} must contain positive values.")


def exponential_growth(time_h: np.ndarray, initial_abundance: float, growth_rate_per_h: float) -> np.ndarray:
    """Calculate exponential growth trajectory."""

    if initial_abundance <= 0:
        raise ValueError("initial_abundance must be positive.")
    if np.any(time_h < 0):
        raise ValueError("time_h must be non-negative.")

    return initial_abundance * np.exp(growth_rate_per_h * time_h)


def logistic_growth(time_h: np.ndarray, initial_abundance: float, growth_rate_per_h: float, carrying_capacity: float) -> np.ndarray:
    """Calculate logistic growth trajectory."""

    if initial_abundance <= 0:
        raise ValueError("initial_abundance must be positive.")
    if carrying_capacity <= initial_abundance:
        raise ValueError("carrying_capacity must exceed initial_abundance.")
    if np.any(time_h < 0):
        raise ValueError("time_h must be non-negative.")

    return carrying_capacity / (
        1 + ((carrying_capacity - initial_abundance) / initial_abundance) * np.exp(-growth_rate_per_h * time_h)
    )


def fit_exponential_growth(time_h: np.ndarray, abundance: np.ndarray) -> GrowthFit:
    """Fit log-linear exponential growth and return interpretable parameters."""

    if len(time_h) != len(abundance):
        raise ValueError("time_h and abundance must have equal length.")
    if len(time_h) < 3:
        raise ValueError("At least three observations are recommended for fitting.")

    if np.any(time_h < 0):
        raise ValueError("time_h must be non-negative.")

    validate_positive(abundance, "abundance")

    slope, intercept = np.polyfit(time_h, np.log(abundance), 1)
    fitted_log = intercept + slope * time_h
    observed_log = np.log(abundance)

    ss_res = np.sum((observed_log - fitted_log) ** 2)
    ss_tot = np.sum((observed_log - np.mean(observed_log)) ** 2)
    r_squared = 1 - ss_res / ss_tot if ss_tot > 0 else math.nan

    doubling_time = math.log(2) / slope if slope > 0 else math.nan

    return GrowthFit(
        growth_rate_per_h=float(slope),
        initial_abundance=float(math.exp(intercept)),
        doubling_time_h=float(doubling_time),
        r_squared_log_space=float(r_squared),
    )


def monod_growth_rate(substrate: np.ndarray, mu_max: float, ks: float) -> np.ndarray:
    """Calculate Monod-style substrate-limited growth rate."""

    if mu_max < 0:
        raise ValueError("mu_max must be non-negative.")
    if ks <= 0:
        raise ValueError("ks must be positive.")
    if np.any(substrate < 0):
        raise ValueError("substrate values must be non-negative.")

    return mu_max * substrate / (ks + substrate)


def biomass_yield(delta_biomass: float, substrate_consumed: float) -> float:
    """Calculate biomass yield on substrate."""

    if substrate_consumed <= 0:
        raise ValueError("substrate_consumed must be positive.")
    return delta_biomass / substrate_consumed


def doubling_time(growth_rate_per_h: float) -> float:
    """Calculate doubling time from positive exponential growth rate."""

    if growth_rate_per_h <= 0:
        return math.nan
    return math.log(2) / growth_rate_per_h


def main() -> None:
    """Run simple smoke-test outputs."""

    time_h = np.array([0, 12, 24, 36, 48], dtype=float)
    abundance = np.array([1e5, 1.4e5, 2e5, 2.8e5, 4e5], dtype=float)

    fit = fit_exponential_growth(time_h, abundance)
    print(fit)

    substrate = np.array([0, 1, 2.5, 5, 10], dtype=float)
    print(monod_growth_rate(substrate, mu_max=0.08, ks=2.5))


if __name__ == "__main__":
    main()
