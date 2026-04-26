"""
Oxygen limitation workflow.

Run:
    python python/oxygen_limitation.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd

from water_energy_core import oxygen_limited_energy_rate


ARTICLE_DIR = Path(__file__).resolve().parents[1]
OXYGEN_PATH = ARTICLE_DIR / "data" / "oxygen_scenarios.csv"


def main() -> None:
    """Calculate oxygen-limited relative energy rate."""

    df = pd.read_csv(OXYGEN_PATH)

    df["relative_energy_rate"] = oxygen_limited_energy_rate(
        df["oxygen_mg_L"].to_numpy(dtype=float),
        float(df["half_saturation_mg_L"].iloc[0]),
        float(df["max_relative_energy_rate"].iloc[0]),
    )

    df["oxygen_limitation"] = 1 - df["relative_energy_rate"]

    print(df.round(5).to_string(index=False))


if __name__ == "__main__":
    main()
