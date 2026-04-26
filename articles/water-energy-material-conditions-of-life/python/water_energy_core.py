"""
Core water-energy biology models and validation utilities.

Run:
    python python/water_energy_core.py
"""

from __future__ import annotations

from dataclasses import dataclass
import math
from typing import Iterable

import numpy as np


R_GAS_L_ATM = 0.082057  # L atm mol^-1 K^-1


@dataclass(frozen=True)
class GrowthFit:
    """Container for exponential growth-fit outputs."""

    growth_rate_per_h: float
    initial_abundance: float
    doubling_time_h: float
    r_squared_log_space: float


def validate_finite(values: Iterable[float], label: str) -> None:
    """Raise ValueError if any value is non-finite."""

    arr = np.asarray(list(values), dtype=float)
    if np.any(~np.isfinite(arr)):
        raise ValueError(f"{label} contains non-finite values.")


def osmotic_pressure_atm(van_t_hoff_factor: float, concentration_mol_L: float, temperature_K: float) -> float:
    """Calculate osmotic pressure using Pi = i C R T."""

    if van_t_hoff_factor <= 0:
        raise ValueError("van_t_hoff_factor must be positive.")
    if concentration_mol_L < 0:
        raise ValueError("concentration_mol_L must be non-negative.")
    if temperature_K <= 0:
        raise ValueError("temperature_K must be positive.")

    return van_t_hoff_factor * concentration_mol_L * R_GAS_L_ATM * temperature_K


def water_potential_total(
    solute_potential_MPa: float,
    pressure_potential_MPa: float,
    gravitational_potential_MPa: float,
    matric_potential_MPa: float,
) -> float:
    """Calculate total water potential."""

    validate_finite(
        [
            solute_potential_MPa,
            pressure_potential_MPa,
            gravitational_potential_MPa,
            matric_potential_MPa,
        ],
        "water potential components",
    )

    return (
        solute_potential_MPa
        + pressure_potential_MPa
        + gravitational_potential_MPa
        + matric_potential_MPa
    )


def homeostatic_solution(time: np.ndarray, initial_value: float, setpoint: float, correction_rate: float) -> np.ndarray:
    """Analytical return toward setpoint."""

    if correction_rate < 0:
        raise ValueError("correction_rate must be non-negative.")
    if np.any(time < 0):
        raise ValueError("time values must be non-negative.")

    return setpoint + (initial_value - setpoint) * np.exp(-correction_rate * time)


def fit_exponential_growth(time_h: np.ndarray, abundance: np.ndarray) -> GrowthFit:
    """Fit log-linear exponential growth and return interpretable parameters."""

    if len(time_h) != len(abundance):
        raise ValueError("time_h and abundance must have equal length.")
    if len(time_h) < 3:
        raise ValueError("At least three observations are recommended for fitting.")
    if np.any(time_h < 0):
        raise ValueError("time_h must be non-negative.")
    if np.any(abundance <= 0):
        raise ValueError("abundance must be positive.")

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


def monod_rate(substrate: np.ndarray, mu_max: float, half_saturation: float) -> np.ndarray:
    """Calculate Monod-style substrate-limited rate."""

    if mu_max < 0:
        raise ValueError("mu_max must be non-negative.")
    if half_saturation <= 0:
        raise ValueError("half_saturation must be positive.")
    if np.any(substrate < 0):
        raise ValueError("substrate values must be non-negative.")

    return mu_max * substrate / (half_saturation + substrate)


def oxygen_limited_energy_rate(
    oxygen_mg_L: np.ndarray,
    half_saturation_mg_L: float,
    max_relative_energy_rate: float,
) -> np.ndarray:
    """Calculate relative energy rate under oxygen limitation."""

    if half_saturation_mg_L <= 0:
        raise ValueError("half_saturation_mg_L must be positive.")
    if max_relative_energy_rate < 0:
        raise ValueError("max_relative_energy_rate must be non-negative.")
    if np.any(oxygen_mg_L < 0):
        raise ValueError("oxygen_mg_L must be non-negative.")

    return max_relative_energy_rate * oxygen_mg_L / (half_saturation_mg_L + oxygen_mg_L)


def main() -> None:
    """Run simple smoke-test outputs."""

    print("osmotic_pressure_atm=", round(osmotic_pressure_atm(1, 0.30, 298), 6))
    print("water_potential_MPa=", round(water_potential_total(-0.6, 0.45, 0.01, -0.02), 6))

    time = np.linspace(0, 20, 11)
    print(homeostatic_solution(time, 10.0, 2.0, 0.4))

    oxygen = np.array([0, 1, 4, 8], dtype=float)
    print(oxygen_limited_energy_rate(oxygen, 2.0, 1.0))


if __name__ == "__main__":
    main()
