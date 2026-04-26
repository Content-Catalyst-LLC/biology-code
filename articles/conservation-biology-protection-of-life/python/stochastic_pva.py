"""
Stochastic population viability analysis for conservation biology.

This script simulates population trajectories under environmental variability
and occasional catastrophe events. It estimates extinction and quasi-extinction
risk for a compact educational example.

Run:
    python python/stochastic_pva.py
"""

from __future__ import annotations

import numpy as np
import pandas as pd


def simulate_pva(
    initial_population: int = 120,
    years: int = 50,
    simulations: int = 1000,
    mean_growth_rate: float = 0.04,
    sd_growth_rate: float = 0.08,
    mean_carrying_capacity: float = 250.0,
    sd_carrying_capacity: float = 20.0,
    catastrophe_probability: float = 0.05,
    catastrophe_multiplier: float = 0.65,
    quasi_extinction_threshold: int = 20,
    random_seed: int = 42,
) -> dict[str, float | np.ndarray]:
    """Simulate stochastic population trajectories."""

    rng = np.random.default_rng(random_seed)
    trajectories = np.full((years + 1, simulations), np.nan)
    trajectories[0, :] = initial_population

    for simulation in range(simulations):
        population_size = float(initial_population)

        for year in range(1, years + 1):
            growth_rate = rng.normal(mean_growth_rate, sd_growth_rate)
            carrying_capacity = max(
                10.0,
                rng.normal(mean_carrying_capacity, sd_carrying_capacity),
            )

            # Stochastic logistic growth.
            population_size = population_size + growth_rate * population_size * (
                1.0 - population_size / carrying_capacity
            )

            # Catastrophe event such as drought, wildfire, disease, or storm impact.
            if rng.random() < catastrophe_probability:
                population_size *= catastrophe_multiplier

            population_size = max(0.0, round(population_size))
            trajectories[year, simulation] = population_size

            if population_size == 0:
                trajectories[year:, simulation] = 0
                break

    final_sizes = trajectories[-1, :]
    minimum_sizes = np.nanmin(trajectories, axis=0)

    return {
        "trajectories": trajectories,
        "extinction_risk": float(np.mean(final_sizes == 0)),
        "quasi_extinction_risk": float(
            np.mean(minimum_sizes <= quasi_extinction_threshold)
        ),
        "median_final_size": float(np.nanmedian(final_sizes)),
        "mean_final_size": float(np.nanmean(final_sizes)),
    }


def main() -> None:
    """Run the example simulation and print summary statistics."""

    result = simulate_pva()

    summary = pd.DataFrame(
        [
            {
                "extinction_risk": result["extinction_risk"],
                "quasi_extinction_risk": result["quasi_extinction_risk"],
                "median_final_size": result["median_final_size"],
                "mean_final_size": result["mean_final_size"],
            }
        ]
    )

    print(summary.round(3).to_string(index=False))


if __name__ == "__main__":
    main()
