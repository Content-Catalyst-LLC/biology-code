"""
Cellular architecture condition scoring.

Run:
    python python/cellular_architecture_condition_scoring.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
CONDITION_PATH = ARTICLE_DIR / "data" / "cellular_architecture_condition_sites.csv"


def validate_unit_interval(df: pd.DataFrame, columns: list[str]) -> None:
    """Validate that specified columns are scaled between zero and one."""

    for col in columns:
        if ((df[col] < 0) | (df[col] > 1)).any():
            raise ValueError(f"{col} must be scaled between 0 and 1.")


def condition_class(score: float) -> str:
    """Classify cellular architecture condition score."""

    if score >= 0.72:
        return "strong_cellular_architecture"
    if score >= 0.52:
        return "moderate_cellular_architecture"
    return "constrained_or_high_uncertainty_architecture"


def main() -> None:
    """Score cellular architecture condition examples."""

    sites = pd.read_csv(CONDITION_PATH)

    score_columns = [
        "membrane_integrity",
        "transport_capacity",
        "organelle_specialization",
        "trafficking_coordination",
        "energy_compartment_function",
        "turnover_capacity",
        "stress_penalty",
    ]

    validate_unit_interval(sites, score_columns)

    sites["cellular_architecture_score"] = (
        0.17 * sites["membrane_integrity"]
        + 0.15 * sites["transport_capacity"]
        + 0.14 * sites["organelle_specialization"]
        + 0.15 * sites["trafficking_coordination"]
        + 0.15 * sites["energy_compartment_function"]
        + 0.14 * sites["turnover_capacity"]
        + 0.10 * (1 - sites["stress_penalty"])
    )

    sites["condition_class"] = sites["cellular_architecture_score"].apply(condition_class)

    print(
        sites.sort_values("cellular_architecture_score", ascending=False)
        .round(3)
        .to_string(index=False)
    )


if __name__ == "__main__":
    main()
