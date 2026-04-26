"""
Enzyme and biochemical pathway condition scoring.

Run:
    python python/enzyme_condition_scoring.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
CONDITION_PATH = ARTICLE_DIR / "data" / "enzyme_condition_sites.csv"


def condition_class(score: float) -> str:
    """Classify enzyme pathway condition score."""

    if score >= 0.72:
        return "strong_enzyme_pathway_function"
    if score >= 0.52:
        return "moderate_enzyme_pathway_function"
    return "constrained_or_high_uncertainty_pathway"


def main() -> None:
    """Score enzyme pathway condition examples."""

    sites = pd.read_csv(CONDITION_PATH)

    sites["enzyme_pathway_score"] = (
        0.17 * sites["catalytic_capacity"]
        + 0.14 * sites["substrate_access"]
        + 0.15 * sites["regulatory_control"]
        + 0.14 * sites["cofactor_availability"]
        + 0.16 * sites["pathway_integration"]
        + 0.14 * sites["environmental_stability"]
        + 0.10 * (1 - sites["inhibition_risk"])
    )

    sites["condition_class"] = sites["enzyme_pathway_score"].apply(condition_class)

    print(
        sites.sort_values("enzyme_pathway_score", ascending=False)
        .round(3)
        .to_string(index=False)
    )


if __name__ == "__main__":
    main()
