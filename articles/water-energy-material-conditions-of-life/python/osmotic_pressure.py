"""
Osmotic pressure workflow.

Run:
    python python/osmotic_pressure.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd

from water_energy_core import osmotic_pressure_atm


ARTICLE_DIR = Path(__file__).resolve().parents[1]
SOLUTE_PATH = ARTICLE_DIR / "data" / "solute_conditions.csv"


def main() -> None:
    """Calculate osmotic pressure across solute conditions."""

    df = pd.read_csv(SOLUTE_PATH)

    df["osmotic_pressure_atm"] = [
        osmotic_pressure_atm(i, c, t)
        for i, c, t in zip(
            df["van_t_hoff_factor"],
            df["concentration_mol_L"],
            df["temperature_K"],
        )
    ]

    df["relative_water_stress"] = df["osmotic_pressure_atm"] / df["osmotic_pressure_atm"].max()

    print(df.round(5).to_string(index=False))


if __name__ == "__main__":
    main()
