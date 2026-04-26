"""
Biosphere carbon-balance scenario model.

This script calculates a simplified net atmospheric carbon increment:

net_atmospheric_increment =
    anthropogenic emissions + disturbance release - land uptake - ocean uptake

Run:
    python python/biosphere_carbon_balance.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
DATA_PATH = ARTICLE_DIR / "data" / "carbon_scenarios.csv"


def calculate_net_increment(row: pd.Series, year: int) -> float:
    """Calculate the stylized net atmospheric carbon increment for one year."""

    emissions = row["emissions_start"] * (1.0 + row["emissions_growth"]) ** (year - 1)
    disturbance = row["disturbance_mean"]
    land_uptake = row["land_uptake_mean"]
    ocean_uptake = row["ocean_uptake_mean"]

    return emissions + disturbance - land_uptake - ocean_uptake


def main() -> None:
    """Compare final-year outcomes across scenarios."""

    scenarios = pd.read_csv(DATA_PATH)
    horizon_year = 50

    rows = []
    for _, row in scenarios.iterrows():
        net_increment = calculate_net_increment(row, horizon_year)
        rows.append(
            {
                "scenario": row["scenario"],
                "year": horizon_year,
                "net_atmospheric_increment": net_increment,
            }
        )

    output = pd.DataFrame(rows)
    print(output.round(3).to_string(index=False))


if __name__ == "__main__":
    main()
