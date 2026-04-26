"""
Compact trophic interaction screening.

This script simulates producer, herbivore, and carnivore dynamics with
disturbance and an ecosystem biomass pool.

Run:
    python python/trophic_interaction_screening.py
"""

from __future__ import annotations

import numpy as np
import pandas as pd


def simulate_ecology(
    time_steps: int = 200,
    random_seed: int = 42,
) -> pd.DataFrame:
    """Simulate a compact producer-herbivore-carnivore ecosystem."""

    rng = np.random.default_rng(random_seed)

    producers = 80.0
    herbivores = 20.0
    carnivores = 5.0
    biomass_pool = 50.0

    rows = []

    for time_step in range(1, time_steps + 1):
        if rng.random() < 0.04:
            producers *= 0.70
            herbivores *= 0.70
            biomass_pool *= 0.70

        delta_producers = (
            0.08 * producers * (1.0 - producers / 200.0)
            - 0.003 * producers * herbivores
        )

        delta_herbivores = (
            0.12 * 0.003 * producers * herbivores
            - 0.03 * herbivores
            - 0.002 * herbivores * carnivores
        )

        delta_carnivores = (
            0.10 * 0.002 * herbivores * carnivores
            - 0.02 * carnivores
        )

        delta_biomass_pool = (
            0.20 * producers
            - 0.08 * herbivores
            - 0.05 * carnivores
            - 0.04 * biomass_pool
            + 0.03 * (herbivores + carnivores)
        )

        producers = max(0.0, producers + delta_producers)
        herbivores = max(0.0, herbivores + delta_herbivores)
        carnivores = max(0.0, carnivores + delta_carnivores)
        biomass_pool = max(0.0, biomass_pool + delta_biomass_pool)

        rows.append(
            {
                "time": time_step,
                "producers": producers,
                "herbivores": herbivores,
                "carnivores": carnivores,
                "biomass_pool": biomass_pool,
            }
        )

    return pd.DataFrame(rows)


def main() -> None:
    """Run the trophic simulation and print summary output."""

    result = simulate_ecology()

    print(result.tail().round(3).to_string(index=False))
    print("\nSummary:")
    print(result.describe().round(3).to_string())


if __name__ == "__main__":
    main()
