"""
Living-order condition scoring.

Run:
    python python/living_order_condition_scoring.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
CONDITION_PATH = ARTICLE_DIR / "data" / "living_order_condition_sites.csv"


def validate_unit_interval(df: pd.DataFrame, columns: list[str]) -> None:
    """Validate that specified columns are scaled between zero and one."""

    for col in columns:
        if ((df[col] < 0) | (df[col] > 1)).any():
            raise ValueError(f"{col} must be scaled between 0 and 1.")


def condition_class(score: float) -> str:
    """Classify living-order condition score."""

    if score >= 0.72:
        return "strong_living_order"
    if score >= 0.52:
        return "moderate_living_order"
    return "constrained_or_high_uncertainty_living_order"


def main() -> None:
    """Score living-order condition examples."""

    sites = pd.read_csv(CONDITION_PATH)

    score_columns = [
        "homeostatic_regulation",
        "metabolic_throughput",
        "structural_integration",
        "developmental_coordination",
        "information_continuity",
        "ecological_relation",
        "stress_penalty",
    ]

    validate_unit_interval(sites, score_columns)

    sites["living_order_score"] = (
        0.17 * sites["homeostatic_regulation"]
        + 0.16 * sites["metabolic_throughput"]
        + 0.15 * sites["structural_integration"]
        + 0.13 * sites["developmental_coordination"]
        + 0.15 * sites["information_continuity"]
        + 0.14 * sites["ecological_relation"]
        + 0.10 * (1 - sites["stress_penalty"])
    )

    sites["condition_class"] = sites["living_order_score"].apply(condition_class)

    print(
        sites.sort_values("living_order_score", ascending=False)
        .round(3)
        .to_string(index=False)
    )


if __name__ == "__main__":
    main()
