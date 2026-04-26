"""
Material-condition scoring workflow.

Run:
    python python/material_condition_scoring.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
CONDITION_PATH = ARTICLE_DIR / "data" / "material_condition_sites.csv"


def validate_unit_interval(df: pd.DataFrame, columns: list[str]) -> None:
    """Validate that specified columns are scaled between zero and one."""

    for col in columns:
        if ((df[col] < 0) | (df[col] > 1)).any():
            raise ValueError(f"{col} must be scaled between 0 and 1.")


def condition_class(score: float) -> str:
    """Classify material condition score."""

    if score >= 0.72:
        return "strong_material_conditions"
    if score >= 0.52:
        return "moderate_material_conditions"
    return "constrained_or_high_uncertainty_conditions"


def main() -> None:
    """Score material condition examples."""

    sites = pd.read_csv(CONDITION_PATH)

    score_columns = [
        "water_availability",
        "osmotic_stability",
        "energy_availability",
        "oxygen_support",
        "thermal_suitability",
        "ph_stability",
        "stress_penalty",
    ]

    validate_unit_interval(sites, score_columns)

    sites["material_condition_score"] = (
        0.17 * sites["water_availability"]
        + 0.15 * sites["osmotic_stability"]
        + 0.17 * sites["energy_availability"]
        + 0.14 * sites["oxygen_support"]
        + 0.13 * sites["thermal_suitability"]
        + 0.14 * sites["ph_stability"]
        + 0.10 * (1 - sites["stress_penalty"])
    )

    sites["condition_class"] = sites["material_condition_score"].apply(condition_class)

    print(
        sites.sort_values("material_condition_score", ascending=False)
        .round(3)
        .to_string(index=False)
    )


if __name__ == "__main__":
    main()
