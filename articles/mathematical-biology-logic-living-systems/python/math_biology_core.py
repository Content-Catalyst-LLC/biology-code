"""
Core mathematical-biology utilities.

Run:
    python python/math_biology_core.py
"""

from __future__ import annotations

from dataclasses import dataclass
import math
import random
from typing import Iterable

import numpy as np


@dataclass(frozen=True)
class LogisticParameters:
    initial_population: float
    growth_rate: float
    carrying_capacity: float


@dataclass(frozen=True)
class SIRParameters:
    beta: float
    gamma: float
    susceptible0: float
    infected0: float
    recovered0: float


def validate_nonnegative(value: float, label: str) -> None:
    if value < 0:
        raise ValueError(f"{label} must be non-negative.")


def logistic_growth(time: np.ndarray, params: LogisticParameters) -> np.ndarray:
    """Calculate logistic growth trajectory."""

    if params.initial_population <= 0:
        raise ValueError("initial_population must be positive.")
    if params.carrying_capacity <= params.initial_population:
        raise ValueError("carrying_capacity must exceed initial_population.")
    validate_nonnegative(params.growth_rate, "growth_rate")

    return params.carrying_capacity / (
        1
        + ((params.carrying_capacity - params.initial_population) / params.initial_population)
        * np.exp(-params.growth_rate * time)
    )


def michaelis_menten(substrate: np.ndarray, vmax: float, km: float) -> np.ndarray:
    """Calculate Michaelis-Menten enzyme velocity."""

    validate_nonnegative(vmax, "vmax")
    if km <= 0:
        raise ValueError("km must be positive.")
    if np.any(substrate < 0):
        raise ValueError("substrate values must be non-negative.")

    return vmax * substrate / (km + substrate)


def simulate_sir(params: SIRParameters, time_end: float, dt: float) -> dict[str, np.ndarray]:
    """Simulate a simple SIR model using Euler integration."""

    if params.beta < 0 or params.gamma < 0:
        raise ValueError("beta and gamma must be non-negative.")
    if min(params.susceptible0, params.infected0, params.recovered0) < 0:
        raise ValueError("initial compartments must be non-negative.")
    if dt <= 0:
        raise ValueError("dt must be positive.")

    time = np.arange(0, time_end + dt, dt)
    susceptible = np.zeros_like(time)
    infected = np.zeros_like(time)
    recovered = np.zeros_like(time)

    susceptible[0] = params.susceptible0
    infected[0] = params.infected0
    recovered[0] = params.recovered0

    for i in range(1, len(time)):
        ds = -params.beta * susceptible[i - 1] * infected[i - 1]
        di = params.beta * susceptible[i - 1] * infected[i - 1] - params.gamma * infected[i - 1]
        dr = params.gamma * infected[i - 1]

        susceptible[i] = max(susceptible[i - 1] + ds * dt, 0.0)
        infected[i] = max(infected[i - 1] + di * dt, 0.0)
        recovered[i] = max(recovered[i - 1] + dr * dt, 0.0)

    return {
        "time": time,
        "susceptible": susceptible,
        "infected": infected,
        "recovered": recovered,
    }


def simulate_predator_prey(
    prey0: float,
    predator0: float,
    alpha: float,
    beta: float,
    delta: float,
    gamma: float,
    time_end: float,
    dt: float,
) -> dict[str, np.ndarray]:
    """Simulate Lotka-Volterra predator-prey dynamics using Euler integration."""

    if min(prey0, predator0, alpha, beta, delta, gamma) < 0:
        raise ValueError("states and parameters must be non-negative.")
    if dt <= 0:
        raise ValueError("dt must be positive.")

    time = np.arange(0, time_end + dt, dt)
    prey = np.zeros_like(time)
    predator = np.zeros_like(time)

    prey[0] = prey0
    predator[0] = predator0

    for i in range(1, len(time)):
        dprey = alpha * prey[i - 1] - beta * prey[i - 1] * predator[i - 1]
        dpredator = delta * prey[i - 1] * predator[i - 1] - gamma * predator[i - 1]

        prey[i] = max(prey[i - 1] + dprey * dt, 0.0)
        predator[i] = max(predator[i - 1] + dpredator * dt, 0.0)

    return {"time": time, "prey": prey, "predator": predator}


def simulate_birth_death(
    initial_population: int,
    birth_rate: float,
    death_rate: float,
    time_end: float,
    seed: int,
) -> list[dict[str, float | int | str]]:
    """Simulate a continuous-time stochastic birth-death process."""

    if initial_population < 0:
        raise ValueError("initial_population must be non-negative.")
    if birth_rate < 0 or death_rate < 0:
        raise ValueError("birth_rate and death_rate must be non-negative.")

    random.seed(seed)

    time = 0.0
    population = initial_population
    rows: list[dict[str, float | int | str]] = [
        {"time": time, "population": population, "event": "initial"}
    ]

    while time < time_end and population > 0:
        total_rate = (birth_rate + death_rate) * population

        if total_rate <= 0:
            break

        time += random.expovariate(total_rate)

        if time > time_end:
            break

        if random.random() < birth_rate / (birth_rate + death_rate):
            population += 1
            event = "birth"
        else:
            population -= 1
            event = "death"

        rows.append({"time": time, "population": population, "event": event})

    return rows


def local_sensitivity(base_output: float, perturbed_output: float, base_parameter: float, perturbed_parameter: float) -> float:
    """Approximate normalized local sensitivity."""

    if base_output == 0 or base_parameter == 0:
        return math.nan

    dy = perturbed_output - base_output
    dtheta = perturbed_parameter - base_parameter

    if dtheta == 0:
        return math.nan

    return (base_parameter / base_output) * (dy / dtheta)


def main() -> None:
    time = np.linspace(0, 40, 10)
    trajectory = logistic_growth(time, LogisticParameters(100, 0.30, 2000))
    print("logistic_final=", round(float(trajectory[-1]), 3))

    sir = simulate_sir(SIRParameters(0.35, 0.10, 0.99, 0.01, 0.0), time_end=120, dt=0.05)
    print("sir_peak_infected=", round(float(np.max(sir["infected"])), 6))

    pp = simulate_predator_prey(40, 9, 0.60, 0.025, 0.018, 0.35, 80, 0.01)
    print("predator_prey_final=", round(float(pp["prey"][-1]), 3), round(float(pp["predator"][-1]), 3))

    velocity = michaelis_menten(np.array([0.1, 1.0, 10.0]), 10.0, 2.0)
    print("enzyme_velocity=", np.round(velocity, 4))


if __name__ == "__main__":
    main()
