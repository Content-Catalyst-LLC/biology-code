"""
Core statistics and measurement utilities for biology.

Run:
    python python/statistics_measurement_core.py
"""

from __future__ import annotations

from dataclasses import dataclass
import math
from typing import Iterable

import numpy as np


@dataclass(frozen=True)
class DescriptiveUncertainty:
    n: int
    mean: float
    standard_deviation: float
    standard_error: float
    ci_lower: float
    ci_upper: float


@dataclass(frozen=True)
class CalibrationFit:
    intercept: float
    slope: float
    r_squared: float


def descriptive_uncertainty(values: Iterable[float], confidence_multiplier: float = 1.96) -> DescriptiveUncertainty:
    """Summarize variation and uncertainty in the mean."""

    arr = np.asarray(list(values), dtype=float)

    if len(arr) < 2:
        raise ValueError("At least two measurements are required.")

    n = len(arr)
    mean = float(arr.mean())
    sd = float(arr.std(ddof=1))
    se = sd / math.sqrt(n)

    return DescriptiveUncertainty(
        n=n,
        mean=mean,
        standard_deviation=sd,
        standard_error=se,
        ci_lower=mean - confidence_multiplier * se,
        ci_upper=mean + confidence_multiplier * se,
    )


def combined_standard_uncertainty(components: Iterable[float]) -> float:
    """Combine independent standard uncertainty components by root-sum-of-squares."""

    arr = np.asarray(list(components), dtype=float)

    if np.any(arr < 0):
        raise ValueError("Uncertainty components must be non-negative.")

    return float(math.sqrt(np.sum(arr**2)))


def fit_linear_calibration(concentration: Iterable[float], response: Iterable[float]) -> CalibrationFit:
    """Fit a simple linear calibration curve."""

    x = np.asarray(list(concentration), dtype=float)
    y = np.asarray(list(response), dtype=float)

    if len(x) != len(y):
        raise ValueError("concentration and response must have equal length.")
    if len(x) < 3:
        raise ValueError("At least three standards are recommended.")

    slope, intercept = np.polyfit(x, y, 1)
    fitted = intercept + slope * x

    ss_res = float(np.sum((y - fitted) ** 2))
    ss_tot = float(np.sum((y - y.mean()) ** 2))

    r_squared = 1 - ss_res / ss_tot if ss_tot > 0 else math.nan

    return CalibrationFit(intercept=float(intercept), slope=float(slope), r_squared=float(r_squared))


def concentration_from_response(response: float, fit: CalibrationFit) -> float:
    """Estimate concentration from linear calibration response."""

    if fit.slope == 0:
        raise ValueError("Calibration slope must not be zero.")

    return (response - fit.intercept) / fit.slope


def root_mean_squared_error(errors: Iterable[float]) -> float:
    """Calculate root mean squared error."""

    arr = np.asarray(list(errors), dtype=float)
    return float(math.sqrt(np.mean(arr**2)))


def propagated_uncertainty_product(x: float, y: float, ux: float, uy: float) -> float:
    """Approximate uncertainty for z = x * y assuming independent uncertainties."""

    z = x * y

    if x == 0 or y == 0:
        return math.nan

    relative = math.sqrt((ux / x) ** 2 + (uy / y) ** 2)
    return abs(z) * relative


def main() -> None:
    values = [10.2, 11.1, 9.8, 10.5, 10.9, 11.0, 9.9, 10.4, 11.3, 10.7]
    print(descriptive_uncertainty(values))
    print("combined_uncertainty=", round(combined_standard_uncertainty([0.12, 0.08, 0.15, 0.06, 0.05]), 6))


if __name__ == "__main__":
    main()
