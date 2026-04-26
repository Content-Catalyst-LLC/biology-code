"""
Water potential workflow.

Run:
    python python/water_potential.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd

from water_energy_core import water_potential_total


ARTICLE_DIR = Path(__file__).resolve().parents[1]
WATER_POTENTIAL_PATH = ARTICLE_DIR / "data" / "water_potential_scenarios.csv"


def main() -> None:
    """Calculate total water potential across scenarios."""

    df = pd.read_csv(WATER_POTENTIAL_PATH)

    df["total_water_potential_MPa"] = [
        water_potential_total(s, p, g, m)
        for s, p, g, m in zip(
            df["solute_potential_MPa"],
            df["pressure_potential_MPa"],
            df["gravitational_potential_MPa"],
            df["matric_potential_MPa"],
        )
    ]

    df["relative_dryness_index"] = (
        df["total_water_potential_MPa"].max() - df["total_water_potential_MPa"]
    ) / (
        df["total_water_potential_MPa"].max() - df["total_water_potential_MPa"].min()
    )

    print(df.round(5).to_string(index=False))


if __name__ == "__main__":
    main()
