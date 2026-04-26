"""
Core quantitative cell-biology models and validation utilities.

Run:
    python python/cell_theory_core.py
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
    initial_count: float
    doubling_time_h: float
    r_squared_log_space: float


@dataclass(frozen=True)
class DecayFit:
    """Container for viability-decay fit outputs."""

    loss_rate_per_h: float
    initial_viable_count: float
    half_life_h: float
    r_squared_log_space: float


def validate_finite(values: Iterable[float], label: str) -> None:
    """Raise ValueError if any value is non-finite."""

    arr = np.asarray(list(values), dtype=float)
    if np.any(~np.isfinite(arr)):
        raise ValueError(f"{label} contains non-finite values.")


def fit_exponential_growth(time_h: np.ndarray, cells: np.ndarray) -> GrowthFit:
    """Fit log-linear exponential cell growth."""

    if len(time_h) != len(cells):
        raise ValueError("time_h and cells must have equal length.")
    if len(time_h) < 3:
        raise ValueError("At least three observations are recommended for fitting.")
    if np.any(time_h < 0):
        raise ValueError("time_h must be non-negative.")
    if np.any(cells <= 0):
        raise ValueError("cell counts must be positive.")

    slope, intercept = np.polyfit(time_h, np.log(cells), 1)
    fitted_log = intercept + slope * time_h
    observed_log = np.log(cells)

    ss_res = np.sum((observed_log - fitted_log) ** 2)
    ss_tot = np.sum((observed_log - np.mean(observed_log)) ** 2)
    r_squared = 1 - ss_res / ss_tot if ss_tot > 0 else math.nan
    doubling_time = math.log(2) / slope if slope > 0 else math.nan

    return GrowthFit(
        growth_rate_per_h=float(slope),
        initial_count=float(math.exp(intercept)),
        doubling_time_h=float(doubling_time),
        r_squared_log_space=float(r_squared),
    )


def logistic_growth(time_h: np.ndarray, initial_count: float, growth_rate: float, carrying_capacity: float) -> np.ndarray:
    """Calculate logistic cell-growth trajectory."""

    if initial_count <= 0:
        raise ValueError("initial_count must be positive.")
    if carrying_capacity <= initial_count:
        raise ValueError("carrying_capacity must exceed initial_count.")
    if growth_rate < 0:
        raise ValueError("growth_rate must be non-negative.")
    if np.any(time_h < 0):
        raise ValueError("time values must be non-negative.")

    return carrying_capacity / (
        1 + ((carrying_capacity - initial_count) / initial_count) * np.exp(-growth_rate * time_h)
    )


def fit_viability_decay(time_h: np.ndarray, viable_cells: np.ndarray) -> DecayFit:
    """Fit log-linear viability-decay model."""

    if len(time_h) != len(viable_cells):
        raise ValueError("time_h and viable_cells must have equal length.")
    if len(time_h) < 3:
        raise ValueError("At least three observations are recommended for fitting.")
    if np.any(time_h < 0):
        raise ValueError("time_h must be non-negative.")
    if np.any(viable_cells <= 0):
        raise ValueError("viable cell counts must be positive.")

    slope, intercept = np.polyfit(time_h, np.log(viable_cells), 1)
    fitted_log = intercept + slope * time_h
    observed_log = np.log(viable_cells)

    ss_res = np.sum((observed_log - fitted_log) ** 2)
    ss_tot = np.sum((observed_log - np.mean(observed_log)) ** 2)
    r_squared = 1 - ss_res / ss_tot if ss_tot > 0 else math.nan

    loss_rate = -slope
    half_life = math.log(2) / loss_rate if loss_rate > 0 else math.inf

    return DecayFit(
        loss_rate_per_h=float(loss_rate),
        initial_viable_count=float(math.exp(intercept)),
        half_life_h=float(half_life),
        r_squared_log_space=float(r_squared),
    )


def membrane_flux(diffusion_coefficient_cm2_s: float, concentration_inside: float, concentration_outside: float, distance_cm: float) -> float:
    """Calculate Fick-style membrane flux."""

    if diffusion_coefficient_cm2_s < 0:
        raise ValueError("diffusion_coefficient_cm2_s must be non-negative.")
    if distance_cm <= 0:
        raise ValueError("distance_cm must be positive.")

    gradient = (concentration_outside - concentration_inside) / distance_cm
    return -diffusion_coefficient_cm2_s * gradient


def simulate_cell_cycle(
    time_h: np.ndarray,
    g1_initial: float,
    s_initial: float,
    g2m_initial: float,
    k1: float,
    k2: float,
    km: float,
) -> dict[str, np.ndarray]:
    """Simulate simplified G1-S-G2M compartment transitions."""

    if min(g1_initial, s_initial, g2m_initial, k1, k2, km) < 0:
        raise ValueError("Initial fractions and rates must be non-negative.")
    if len(time_h) < 2:
        raise ValueError("time_h must contain at least two points.")

    g1 = np.zeros_like(time_h, dtype=float)
    s_phase = np.zeros_like(time_h, dtype=float)
    g2m = np.zeros_like(time_h, dtype=float)

    g1[0] = g1_initial
    s_phase[0] = s_initial
    g2m[0] = g2m_initial

    for i in range(1, len(time_h)):
        dt = time_h[i] - time_h[i - 1]

        dg1 = 2 * km * g2m[i - 1] - k1 * g1[i - 1]
        ds = k1 * g1[i - 1] - k2 * s_phase[i - 1]
        dg2m = k2 * s_phase[i - 1] - km * g2m[i - 1]

        g1[i] = max(g1[i - 1] + dg1 * dt, 0)
        s_phase[i] = max(s_phase[i - 1] + ds * dt, 0)
        g2m[i] = max(g2m[i - 1] + dg2m * dt, 0)

    return {"G1": g1, "S": s_phase, "G2M": g2m}


def main() -> None:
    """Run smoke-test outputs."""

    time = np.array([0, 12, 24, 36, 48], dtype=float)
    cells = np.array([1.0e5, 1.4e5, 2.0e5, 2.8e5, 4.0e5], dtype=float)
    print(fit_exponential_growth(time, cells))

    print("flux=", membrane_flux(2.0e-6, 1.0, 0.2, 0.01))

    cycle_time = np.arange(0, 48.01, 0.01)
    sim = simulate_cell_cycle(cycle_time, 0.70, 0.20, 0.10, 0.10, 0.08, 0.06)
    print("final_cycle=", sim["G1"][-1], sim["S"][-1], sim["G2M"][-1])


if __name__ == "__main__":
    main()
