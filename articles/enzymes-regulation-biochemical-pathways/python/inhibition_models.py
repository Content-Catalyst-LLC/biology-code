"""
Competitive and noncompetitive inhibition models.

Run:
    python python/inhibition_models.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
CONDITIONS_PATH = ARTICLE_DIR / "data" / "inhibition_conditions.csv"


def velocity(substrate: np.ndarray, vmax: float, km: float) -> np.ndarray:
    """Michaelis-Menten velocity."""

    return (vmax * substrate) / (km + substrate)


def competitive_velocity(substrate: np.ndarray, vmax: float, km: float, inhibitor: float, ki: float) -> np.ndarray:
    """Competitive inhibition velocity."""

    return (vmax * substrate) / (km * (1 + inhibitor / ki) + substrate)


def noncompetitive_velocity(substrate: np.ndarray, vmax: float, km: float, inhibitor: float, ki: float) -> np.ndarray:
    """Noncompetitive inhibition velocity."""

    return (vmax / (1 + inhibitor / ki)) * substrate / (km + substrate)


def main() -> None:
    """Compare kinetic curves across inhibition conditions."""

    conditions = pd.read_csv(CONDITIONS_PATH)
    substrate = np.array([0.5, 1, 2, 4, 8, 12, 20, 30], dtype=float)

    rows = []

    for _, row in conditions.iterrows():
        if row["inhibition_type"] == "competitive":
            v = competitive_velocity(substrate, row["Vmax"], row["Km"], row["inhibitor_uM"], row["Ki_uM"])
        elif row["inhibition_type"] == "noncompetitive":
            v = noncompetitive_velocity(substrate, row["Vmax"], row["Km"], row["inhibitor_uM"], row["Ki_uM"])
        else:
            v = velocity(substrate, row["Vmax"], row["Km"])

        for s, vel in zip(substrate, v):
            rows.append(
                {
                    "condition": row["condition"],
                    "substrate_mM": s,
                    "velocity_units_min": vel,
                }
            )

    out = pd.DataFrame(rows)
    print(out.round(4).to_string(index=False))


if __name__ == "__main__":
    main()
