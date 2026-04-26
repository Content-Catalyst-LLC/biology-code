"""
Core models for life, death, dormancy, viruses, and biological definition.

Run:
    python python/definition_core.py
"""

from __future__ import annotations

from dataclasses import dataclass
import math
from typing import Iterable

import numpy as np


@dataclass(frozen=True)
class DecayFit:
    """Container for viability-decay fit outputs."""

    loss_rate: float
    initial_viable_count: float
    half_life: float
    r_squared_log_space: float


def validate_finite(values: Iterable[float], label: str) -> None:
    """Raise ValueError if any value is non-finite."""

    arr = np.asarray(list(values), dtype=float)
    if np.any(~np.isfinite(arr)):
        raise ValueError(f"{label} contains non-finite values.")


def exponential_growth(time: np.ndarray, initial_abundance: float, growth_rate: float) -> np.ndarray:
    """Calculate exponential growth trajectory."""

    if initial_abundance <= 0:
        raise ValueError("initial_abundance must be positive.")
    if np.any(time < 0):
        raise ValueError("time values must be non-negative.")

    return initial_abundance * np.exp(growth_rate * time)


def viability_decay(time: np.ndarray, initial_viable_count: float, loss_rate: float) -> np.ndarray:
    """Calculate exponential viability decay."""

    if initial_viable_count <= 0:
        raise ValueError("initial_viable_count must be positive.")
    if loss_rate < 0:
        raise ValueError("loss_rate must be non-negative.")
    if np.any(time < 0):
        raise ValueError("time values must be non-negative.")

    return initial_viable_count * np.exp(-loss_rate * time)


def survival_probability(time: np.ndarray, hazard_rate: float) -> np.ndarray:
    """Calculate survival probability under constant hazard."""

    if hazard_rate < 0:
        raise ValueError("hazard_rate must be non-negative.")
    if np.any(time < 0):
        raise ValueError("time values must be non-negative.")

    return np.exp(-hazard_rate * time)


def fit_viability_decay(time: np.ndarray, live_cells: np.ndarray) -> DecayFit:
    """Fit log-linear viability-decay model."""

    if len(time) != len(live_cells):
        raise ValueError("time and live_cells must have equal length.")
    if len(time) < 3:
        raise ValueError("At least three observations are recommended for fitting.")
    if np.any(time < 0):
        raise ValueError("time must be non-negative.")
    if np.any(live_cells <= 0):
        raise ValueError("live_cells must be positive.")

    slope, intercept = np.polyfit(time, np.log(live_cells), 1)
    fitted_log = intercept + slope * time
    observed_log = np.log(live_cells)

    ss_res = np.sum((observed_log - fitted_log) ** 2)
    ss_tot = np.sum((observed_log - np.mean(observed_log)) ** 2)
    r_squared = 1 - ss_res / ss_tot if ss_tot > 0 else math.nan

    loss_rate = -slope
    half_life = math.log(2) / loss_rate if loss_rate > 0 else math.inf

    return DecayFit(
        loss_rate=float(loss_rate),
        initial_viable_count=float(math.exp(intercept)),
        half_life=float(half_life),
        r_squared_log_space=float(r_squared),
    )


def simulate_dormancy(
    time: np.ndarray,
    dormant_initial: float,
    active_initial: float,
    mortality_rate: float,
    reactivation_rate: float,
) -> dict[str, np.ndarray]:
    """Simulate dormancy loss, activation, and death/loss."""

    if dormant_initial < 0 or active_initial < 0:
        raise ValueError("Initial pools must be non-negative.")
    if mortality_rate < 0 or reactivation_rate < 0:
        raise ValueError("Rates must be non-negative.")
    if len(time) < 2:
        raise ValueError("time must include at least two points.")

    dormant = np.zeros_like(time, dtype=float)
    active = np.zeros_like(time, dtype=float)
    dead_or_lost = np.zeros_like(time, dtype=float)

    dormant[0] = dormant_initial
    active[0] = active_initial

    for i in range(1, len(time)):
        dt = time[i] - time[i - 1]

        d_dormant = -(mortality_rate + reactivation_rate) * dormant[i - 1]
        d_active = reactivation_rate * dormant[i - 1]
        d_lost = mortality_rate * dormant[i - 1]

        dormant[i] = max(dormant[i - 1] + d_dormant * dt, 0)
        active[i] = active[i - 1] + d_active * dt
        dead_or_lost[i] = dead_or_lost[i - 1] + d_lost * dt

    return {
        "dormant": dormant,
        "active": active,
        "dead_or_lost": dead_or_lost,
    }


def simulate_host_virus(
    time: np.ndarray,
    target_initial: float,
    infected_initial: float,
    virus_initial: float,
    beta: float,
    delta: float,
    production: float,
    clearance: float,
) -> dict[str, np.ndarray]:
    """Simulate simple host-virus dynamics."""

    if min(target_initial, infected_initial, virus_initial) < 0:
        raise ValueError("Initial values must be non-negative.")
    if min(beta, delta, production, clearance) < 0:
        raise ValueError("Rates must be non-negative.")
    if len(time) < 2:
        raise ValueError("time must include at least two points.")

    target = np.zeros_like(time, dtype=float)
    infected = np.zeros_like(time, dtype=float)
    virus = np.zeros_like(time, dtype=float)

    target[0] = target_initial
    infected[0] = infected_initial
    virus[0] = virus_initial

    for i in range(1, len(time)):
        dt = time[i] - time[i - 1]

        d_target = -beta * target[i - 1] * virus[i - 1]
        d_infected = beta * target[i - 1] * virus[i - 1] - delta * infected[i - 1]
        d_virus = production * infected[i - 1] - clearance * virus[i - 1]

        target[i] = max(target[i - 1] + d_target * dt, 0)
        infected[i] = max(infected[i - 1] + d_infected * dt, 0)
        virus[i] = max(virus[i - 1] + d_virus * dt, 0)

    return {
        "target_cells": target,
        "infected_cells": infected,
        "free_virus": virus,
    }


def heuristic_life_score(criteria: dict[str, float], weights: dict[str, float]) -> float:
    """Calculate explicit weighted life-criteria score."""

    for key, value in criteria.items():
        if value < 0 or value > 1:
            raise ValueError(f"{key} must be between 0 and 1.")

    weight_sum = sum(weights.values())
    if abs(weight_sum - 1.0) > 1e-6:
        raise ValueError(f"Weights must sum to 1. Current sum: {weight_sum}")

    return sum(criteria[key] * weights[key] for key in weights)


def main() -> None:
    """Run simple smoke-test outputs."""

    time = np.array([0, 12, 24, 36, 48], dtype=float)
    live = np.array([1.0e6, 7.4e5, 5.5e5, 3.8e5, 2.5e5], dtype=float)
    print(fit_viability_decay(time, live))

    simulation_time = np.arange(0, 20.01, 0.01)
    dormancy = simulate_dormancy(simulation_time, 1e6, 0, 0.02, 0.05)
    print("final_dormant=", round(dormancy["dormant"][-1], 3))

    virus = simulate_host_virus(np.arange(0, 10.01, 0.01), 1e6, 0, 1e3, 2e-8, 0.5, 100, 2.0)
    print("final_virus=", round(virus["free_virus"][-1], 3))


if __name__ == "__main__":
    main()
