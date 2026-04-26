"""
Core living-order models and validation utilities.

Run:
    python python/living_order_core.py
"""

from __future__ import annotations

from dataclasses import dataclass
import math
from typing import Iterable

import numpy as np


@dataclass(frozen=True)
class GrowthFit:
    """Container for exponential growth-fit outputs."""

    growth_rate: float
    initial_abundance: float
    doubling_time: float
    r_squared_log_space: float


def validate_finite(values: Iterable[float], label: str) -> None:
    """Raise ValueError if any value is non-finite."""

    arr = np.asarray(list(values), dtype=float)
    if np.any(~np.isfinite(arr)):
        raise ValueError(f"{label} contains non-finite values.")


def homeostatic_solution(time: np.ndarray, initial_value: float, setpoint: float, correction_rate: float) -> np.ndarray:
    """Analytical return toward setpoint."""

    if correction_rate < 0:
        raise ValueError("correction_rate must be non-negative.")
    if np.any(time < 0):
        raise ValueError("time values must be non-negative.")

    return setpoint + (initial_value - setpoint) * np.exp(-correction_rate * time)


def recovery_index(initial_value: float, final_value: float, setpoint: float) -> float:
    """Calculate simplified perturbation recovery index."""

    initial_deviation = abs(initial_value - setpoint)
    if initial_deviation == 0:
        return 1.0

    return 1 - abs(final_value - setpoint) / initial_deviation


def fit_exponential_growth(time: np.ndarray, abundance: np.ndarray) -> GrowthFit:
    """Fit log-linear exponential growth and return interpretable parameters."""

    if len(time) != len(abundance):
        raise ValueError("time and abundance must have equal length.")
    if len(time) < 3:
        raise ValueError("At least three observations are recommended for fitting.")
    if np.any(time < 0):
        raise ValueError("time must be non-negative.")
    if np.any(abundance <= 0):
        raise ValueError("abundance must be positive.")

    slope, intercept = np.polyfit(time, np.log(abundance), 1)
    fitted_log = intercept + slope * time
    observed_log = np.log(abundance)

    ss_res = np.sum((observed_log - fitted_log) ** 2)
    ss_tot = np.sum((observed_log - np.mean(observed_log)) ** 2)
    r_squared = 1 - ss_res / ss_tot if ss_tot > 0 else math.nan

    doubling_time = math.log(2) / slope if slope > 0 else math.nan

    return GrowthFit(
        growth_rate=float(slope),
        initial_abundance=float(math.exp(intercept)),
        doubling_time=float(doubling_time),
        r_squared_log_space=float(r_squared),
    )


def logistic_growth(time: np.ndarray, initial_abundance: float, growth_rate: float, carrying_capacity: float) -> np.ndarray:
    """Calculate logistic growth trajectory."""

    if initial_abundance <= 0:
        raise ValueError("initial_abundance must be positive.")
    if carrying_capacity <= initial_abundance:
        raise ValueError("carrying_capacity must exceed initial_abundance.")
    if np.any(time < 0):
        raise ValueError("time values must be non-negative.")

    return carrying_capacity / (
        1 + ((carrying_capacity - initial_abundance) / initial_abundance) * np.exp(-growth_rate * time)
    )


def feedback_response(state: float, setpoint: float, gain: float) -> float:
    """Calculate simple negative-feedback corrective response."""

    if gain < 0:
        raise ValueError("gain must be non-negative.")

    return gain * (setpoint - state)


def main() -> None:
    """Run smoke-test outputs."""

    time = np.linspace(0, 20, 11)
    states = homeostatic_solution(time, 10.0, 2.0, 0.4)

    print(states)
    print("recovery_index=", round(recovery_index(10.0, states[-1], 2.0), 6))

    growth_time = np.array([0, 2, 4, 6, 8, 10], dtype=float)
    abundance = np.array([100, 149, 222, 331, 493, 735], dtype=float)
    print(fit_exponential_growth(growth_time, abundance))

    print("feedback_response=", round(feedback_response(10.0, 2.0, 0.5), 6))


if __name__ == "__main__":
    main()
