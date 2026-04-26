"""
Stochastic population viability simulation.

This script simulates logistic growth with variable growth rate, variable
carrying capacity, harvest, catastrophes, and quasi-extinction screening.

Run:
    python python/stochastic_population_viability.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
SCENARIO_PATH = ARTICLE_DIR / "data" / "population_scenarios.csv"


def simulate_population(
    years: int,
    n_sims: int,
    initial_population: float,
    growth_rate_mean: float,
    growth_rate_sd: float,
    carrying_capacity_mean: float,
    carrying_capacity_sd: float,
    harvest: float,
    catastrophe_probability: float,
    catastrophe_multiplier: float,
    quasi_extinction_threshold: float,
    random_seed: int = 123,
) -> dict[str, float]:
    """Run stochastic population viability simulation."""

    rng = np.random.default_rng(random_seed)
    trajectories = np.full((years + 1, n_sims), np.nan)
    trajectories[0, :] = initial_population

    for sim in range(n_sims):
        population_size = initial_population

        for year in range(1, years + 1):
            growth_rate_t = rng.normal(growth_rate_mean, growth_rate_sd)
            carrying_capacity_t = max(
                quasi_extinction_threshold,
                rng.normal(carrying_capacity_mean, carrying_capacity_sd),
            )

            population_size = (
                population_size
                + growth_rate_t
                * population_size
                * (1.0 - population_size / carrying_capacity_t)
                - harvest
            )

            if rng.random() < catastrophe_probability:
                population_size *= catastrophe_multiplier

            population_size = max(0.0, population_size)
            trajectories[year, sim] = population_size

            if population_size == 0.0:
                trajectories[year:, sim] = 0.0
                break

    final_sizes = trajectories[years, :]
    minimum_sizes = np.nanmin(trajectories, axis=0)

    return {
        "extinction_risk": float(np.mean(final_sizes == 0.0)),
        "quasi_extinction_risk": float(
            np.mean(minimum_sizes <= quasi_extinction_threshold)
        ),
        "mean_final": float(np.mean(final_sizes)),
        "median_final": float(np.median(final_sizes)),
    }


def main() -> None:
    """Compare population viability across scenarios."""

    scenarios = pd.read_csv(SCENARIO_PATH)

    rows = []
    for _, row in scenarios.iterrows():
        result = simulate_population(
            years=50,
            n_sims=1000,
            initial_population=row["initial_population"],
            growth_rate_mean=row["growth_rate_mean"],
            growth_rate_sd=row["growth_rate_sd"],
            carrying_capacity_mean=row["carrying_capacity_mean"],
            carrying_capacity_sd=row["carrying_capacity_sd"],
            harvest=row["harvest"],
            catastrophe_probability=row["catastrophe_probability"],
            catastrophe_multiplier=row["catastrophe_multiplier"],
            quasi_extinction_threshold=row["quasi_extinction_threshold"],
        )
        result["scenario"] = row["scenario"]
        rows.append(result)

    output = pd.DataFrame(rows)[
        [
            "scenario",
            "extinction_risk",
            "quasi_extinction_risk",
            "mean_final",
            "median_final",
        ]
    ]

    print(output.round(3).to_string(index=False))


if __name__ == "__main__":
    main()
