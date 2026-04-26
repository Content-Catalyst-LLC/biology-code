"""
Physiological condition scoring.

This script calculates a transparent regulatory-condition score from feedback,
effector capacity, signal integrity, stress load, environmental pressure,
and recovery support.

Run:
    python python/physiological_condition_scoring.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
CONDITION_PATH = ARTICLE_DIR / "data" / "physiological_condition_scenarios.csv"
THRESHOLDS_PATH = ARTICLE_DIR / "data" / "regulatory_thresholds.csv"


def main() -> None:
    """Calculate physiological condition scores."""

    scenarios = pd.read_csv(CONDITION_PATH)
    threshold_df = pd.read_csv(THRESHOLDS_PATH)
    thresholds = dict(zip(threshold_df["threshold_name"], threshold_df["value"]))

    scenarios["physiological_condition_score"] = (
        0.22 * scenarios["feedback_capacity"]
        + 0.20 * scenarios["effector_capacity"]
        + 0.20 * scenarios["signal_integrity"]
        + 0.18 * scenarios["recovery_support"]
        - 0.12 * scenarios["stress_load"]
        - 0.12 * scenarios["environmental_pressure"]
    )

    conditions = [
        scenarios["physiological_condition_score"] >= thresholds["condition_score_buffered"],
        (scenarios["physiological_condition_score"] >= thresholds["condition_score_stressed"])
        & (scenarios["physiological_condition_score"] < thresholds["condition_score_buffered"]),
        scenarios["physiological_condition_score"] < thresholds["condition_score_stressed"],
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
