"""
Immune condition scoring.

This script calculates a transparent immune-condition score from clearance,
activation, regulation, damage pressure, stress load, and memory support.

Run:
    python python/immune_condition_scoring.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
CONDITION_PATH = ARTICLE_DIR / "data" / "immune_condition_scenarios.csv"


def main() -> None:
    """Calculate immune condition scores."""

    scenarios = pd.read_csv(CONDITION_PATH)

    scenarios["immune_condition_score"] = (
        0.22 * scenarios["clearance_capacity"]
        + 0.18 * scenarios["activation_capacity"]
        + 0.22 * scenarios["regulatory_capacity"]
        + 0.18 * scenarios["memory_support"]
        - 0.15 * scenarios["damage_pressure"]
        - 0.15 * scenarios["stress_load"]
    )

    conditions = [
        scenarios["immune_condition_score"] >= 0.60,
        (scenarios["immune_condition_score"] >= 0.42)
        & (scenarios["immune_condition_score"] < 0.60),
        scenarios["immune_condition_score"] < 0.42,
    ]

    labels = ["relatively-buffered", "stressed", "high-risk"]

    scenarios["condition_class"] = np.select(
        conditions,
        labels,
        default="unknown",
    )

    print(scenarios.round(3).to_string(index=False))


if __name__ == "__main__":
    main()
