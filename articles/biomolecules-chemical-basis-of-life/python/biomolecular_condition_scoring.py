"""
Biomolecular condition scoring.

Run:
    python python/biomolecular_condition_scoring.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
CONDITION_PATH = ARTICLE_DIR / "data" / "biomolecular_condition_sites.csv"


def validate_unit_interval(df: pd.DataFrame, columns: list[str]) -> None:
    """Validate that specified columns are scaled between zero and one."""

    for col in columns:
        if ((df[col] < 0) | (df[col] > 1)).any():
            raise ValueError(f"{col} must be scaled between 0 and 1.")


def condition_class(score: float) -> str:
    """Classify biomolecular condition score."""

    if score >= 0.72:
        return "strong_biomolecular_function"
    if score >= 0.52:
        return "moderate_biomolecular_function"
    return "constrained_or_high_uncertainty_biomolecular_state"


def main() -> None:
    """Score biomolecular condition examples."""

    sites = pd.read_csv(CONDITION_PATH)

    score_columns = [
        "carbohydrate_support",
        "lipid_boundary_function",
        "protein_function",
        "nucleic_acid_integrity",
        "metabolite_balance",
        "cofactor_availability",
        "stress_penalty",
    ]

    validate_unit_interval(sites, score_columns)

    sites["biomolecular_condition_score"] = (
        0.14 * sites["carbohydrate_support"]
        + 0.15 * sites["lipid_boundary_function"]
        + 0.18 * sites["protein_function"]
        + 0.17 * sites["nucleic_acid_integrity"]
        + 0.14 * sites["metabolite_balance"]
        + 0.12 * sites["cofactor_availability"]
        + 0.10 * (1 - sites["stress_penalty"])
    )

    sites["condition_class"] = sites["biomolecular_condition_score"].apply(condition_class)

    print(
        sites.sort_values("biomolecular_condition_score", ascending=False)
        .round(3)
        .to_string(index=False)
    )


if __name__ == "__main__":
    main()
