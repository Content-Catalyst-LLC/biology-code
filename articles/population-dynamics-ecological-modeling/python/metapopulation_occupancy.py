"""
Metapopulation occupancy model.

This script models patch occupancy over time using a compact Levins-style
colonization-extinction equation.

Run:
    python python/metapopulation_occupancy.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
SCENARIO_PATH = ARTICLE_DIR / "data" / "metapopulation_scenarios.csv"


def simulate_occupancy(
    initial_occupancy: float,
    colonization_rate: float,
    extinction_rate: float,
    years: int,
) -> list[float]:
    """Simulate patch occupancy through time."""

    occupancy = initial_occupancy
    values = [occupancy]

    for _ in range(years):
        delta = (
            colonization_rate * occupancy * (1.0 - occupancy)
            - extinction_rate * occupancy
        )
        occupancy = min(1.0, max(0.0, occupancy + delta))
        values.append(occupancy)

    return values


def main() -> None:
    """Compare final occupancy across metapopulation scenarios."""

    scenarios = pd.read_csv(SCENARIO_PATH)

    rows = []
    for _, row in scenarios.iterrows():
        values = simulate_occupancy(
            initial_occupancy=row["initial_occupancy"],
            colonization_rate=row["colonization_rate"],
            extinction_rate=row["extinction_rate"],
            years=int(row["years"]),
        )

        rows.append(
            {
                "scenario": row["scenario"],
                "initial_occupancy": values[0],
                "final_occupancy": values[-1],
                "minimum_occupancy": min(values),
                "maximum_occupancy": max(values),
            }
        )

    print(pd.DataFrame(rows).round(3).to_string(index=False))


if __name__ == "__main__":
    main()
