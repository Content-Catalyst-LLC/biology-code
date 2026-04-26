"""
Functional-integrity screening for biosphere life-support systems.

This script reads normalized biosphere indicators and calculates a composite
functional-integrity score. It also tests sensitivity to rising disturbance.

Run:
    python python/functional_integrity_screening.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
DATA_PATH = ARTICLE_DIR / "data" / "biosphere_units.csv"


def compute_functional_integrity(data: pd.DataFrame) -> pd.DataFrame:
    """Calculate a composite functional-integrity score."""

    result = data.copy()

    result["functional_integrity"] = (
        0.20 * result["primary_production"]
        + 0.18 * result["water_regulation"]
        + 0.18 * result["nutrient_retention"]
        + 0.18 * result["habitat_complexity"]
        + 0.12 * result["connectivity"]
        + 0.14 * result["biodiversity_signal"]
        - 0.20 * result["disturbance_pressure"]
    )

    conditions = [
        result["functional_integrity"] >= 0.70,
        (result["functional_integrity"] >= 0.50)
        & (result["functional_integrity"] < 0.70),
        result["functional_integrity"] < 0.50,
    ]
    labels = ["stable-to-watch", "stressed", "high-risk"]

    result["risk_class"] = np.select(conditions, labels, default="unknown")

    return result


def main() -> None:
    """Run baseline and increased-disturbance screening."""

    units = pd.read_csv(DATA_PATH)
    scored = compute_functional_integrity(units)

    scored["functional_integrity_plus_disturbance"] = (
        0.20 * scored["primary_production"]
        + 0.18 * scored["water_regulation"]
        + 0.18 * scored["nutrient_retention"]
        + 0.18 * scored["habitat_complexity"]
        + 0.12 * scored["connectivity"]
        + 0.14 * scored["biodiversity_signal"]
        - 0.20 * (scored["disturbance_pressure"] + 0.10)
    )

    scored["delta_if_disturbance_rises"] = (
        scored["functional_integrity_plus_disturbance"]
        - scored["functional_integrity"]
    )

    print(
        scored[
            [
                "unit",
                "functional_integrity",
                "risk_class",
                "functional_integrity_plus_disturbance",
                "delta_if_disturbance_rises",
            ]
        ]
        .round(3)
        .to_string(index=False)
    )


if __name__ == "__main__":
    main()
