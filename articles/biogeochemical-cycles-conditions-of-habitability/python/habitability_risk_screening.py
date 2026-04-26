"""
Habitability-support risk screening.

This script calculates a composite habitability-support score from normalized
biogeochemical indicators and then tests a nutrient-loading and oxygen-stress
scenario.

Run:
    python python/habitability_risk_screening.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
DATA_PATH = ARTICLE_DIR / "data" / "habitability_units.csv"


def calculate_habitability_support(data: pd.DataFrame) -> pd.Series:
    """Calculate a composite habitability-support score."""

    return (
        0.18 * data["carbon_uptake_capacity"]
        + 0.16 * data["water_regulation"]
        + 0.14 * data["nitrogen_retention"]
        + 0.14 * data["phosphorus_buffering"]
        + 0.16 * data["oxygen_stability"]
        - 0.10 * data["disturbance_pressure"]
        - 0.06 * data["acidification_pressure"]
        - 0.06 * data["nutrient_loading"]
    )


def classify_risk(score: float) -> str:
    """Classify a habitability-support score."""

    if score >= 0.65:
        return "relatively-buffered"
    if score >= 0.45:
        return "stressed"
    return "high-risk"


def main() -> None:
    """Run baseline and scenario habitability screening."""

    units = pd.read_csv(DATA_PATH)

    units["habitability_support"] = calculate_habitability_support(units)
    units["risk_class"] = units["habitability_support"].apply(classify_risk)

    scenario = units.copy()
    scenario["oxygen_stability"] = scenario["oxygen_stability"] - 0.10
    scenario["nutrient_loading"] = scenario["nutrient_loading"] + 0.12

    units["habitability_support_scenario"] = calculate_habitability_support(scenario)
    units["delta_scenario"] = (
        units["habitability_support_scenario"] - units["habitability_support"]
    )

    print(
        units[
            [
                "unit",
                "habitability_support",
                "risk_class",
                "habitability_support_scenario",
                "delta_scenario",
            ]
        ]
        .round(3)
        .to_string(index=False)
    )


if __name__ == "__main__":
    main()
