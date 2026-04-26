"""
Neural condition screening under environmental and physiological stress.

This script calculates a transparent screening score from recovery rate,
input gain, noise pressure, stress load, and connectivity integrity.

Run:
    python python/neural_condition_screening.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
SCENARIOS_PATH = ARTICLE_DIR / "data" / "neural_condition_scenarios.csv"


def main() -> None:
    """Calculate neural condition scores."""

    scenarios = pd.read_csv(SCENARIOS_PATH)

    scenarios["neural_condition_score"] = (
        0.25 * (scenarios["recovery_rate"] / scenarios["recovery_rate"].max())
        + 0.25 * scenarios["input_gain"]
        + 0.25 * scenarios["connectivity_integrity"]
        - 0.15 * scenarios["noise_pressure"]
        - 0.20 * scenarios["stress_load"]
    )

    conditions = [
        scenarios["neural_condition_score"] >= 0.70,
        (scenarios["neural_condition_score"] >= 0.50)
        & (scenarios["neural_condition_score"] < 0.70),
        scenarios["neural_condition_score"] < 0.50,
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
