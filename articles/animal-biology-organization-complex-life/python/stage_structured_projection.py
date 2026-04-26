"""
Juvenile-adult stage-structured population projection.

Run:
    python python/stage_structured_projection.py
"""

from __future__ import annotations

import numpy as np
import pandas as pd


def main() -> None:
    """Project a juvenile-adult population through time."""

    projection_matrix = np.array(
        [
            [0.0, 1.4],
            [0.35, 0.72],
        ]
    )

    population = np.array([40.0, 25.0])
    years = 20

    trajectory = [population.copy()]

    for _ in range(years):
        population = projection_matrix @ population
        trajectory.append(population.copy())

    results = pd.DataFrame(
        trajectory,
        columns=["juveniles", "adults"],
    )

    results["year"] = range(years + 1)
    results["total_population"] = results["juveniles"] + results["adults"]

    print(results.round(2).to_string(index=False))


if __name__ == "__main__":
    main()
