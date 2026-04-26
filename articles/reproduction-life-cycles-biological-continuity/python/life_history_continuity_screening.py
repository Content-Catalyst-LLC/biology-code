"""
Life-history continuity screening.

This script calculates a comparative continuity score from fecundity,
juvenile survival, adult survival, maturation, dormancy or buffering,
and environmental stress.

Run:
    python python/life_history_continuity_screening.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
UNITS_PATH = ARTICLE_DIR / "data" / "life_history_units.csv"


def calculate_continuity_score(data: pd.DataFrame) -> pd.Series:
    """Calculate synthetic reproductive continuity score."""

    return (
        0.20 * data["fecundity"] / data["fecundity"].max()
        + 0.20 * data["juvenile_survival"]
        + 0.25 * data["adult_survival"]
        + 0.15 * data["maturation_rate"]
        + 0.10 * data["dormancy_or_buffering"]
        - 0.20 * data["environmental_stress"]
    )


def main() -> None:
    """Run baseline and stress scenario continuity scoring."""

    units = pd.read_csv(UNITS_PATH)

    units["continuity_score"] = calculate_continuity_score(units)

    stress = units.copy()
    stress["juvenile_survival"] *= 0.90
    stress["environmental_stress"] += 0.10

    units["continuity_score_stress"] = calculate_continuity_score(stress)
    units["delta_under_stress"] = (
        units["continuity_score_stress"] - units["continuity_score"]
    )

    conditions = [
        units["continuity_score"] >= 0.60,
        (units["continuity_score"] >= 0.45) & (units["continuity_score"] < 0.60),
        units["continuity_score"] < 0.45,
    ]

    labels = ["relatively-buffered", "vulnerable", "high-risk"]
    units["continuity_class"] = np.select(conditions, labels, default="unknown")

    print(units.round(3).to_string(index=False))


if __name__ == "__main__":
    main()
