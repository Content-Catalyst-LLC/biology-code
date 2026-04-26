"""
Selection condition scoring.

Run:
    python python/selection_condition_scoring.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
SITES_PATH = ARTICLE_DIR / "data" / "selection_condition_sites.csv"


def condition_class(score: float) -> str:
    """Classify selection condition score."""

    if score >= 0.70:
        return "high_adaptive_potential"
    if score >= 0.50:
        return "moderate_adaptive_potential"
    return "constrained_or_at_risk"


def main() -> None:
    """Score selection condition examples."""

    sites = pd.read_csv(SITES_PATH)

    sites["selection_condition_score"] = (
        0.18 * sites["standing_variation"]
        + 0.18 * sites["selection_strength"]
        + 0.18 * sites["environmental_match"]
        + 0.16 * sites["demographic_stability"]
        + 0.14 * sites["gene_flow_support"]
        + 0.16 * (1 - sites["constraint_risk"])
    )

    sites["condition_class"] = sites["selection_condition_score"].apply(condition_class)

    print(
        sites.sort_values("selection_condition_score", ascending=False)
        .round(3)
        .to_string(index=False)
    )


if __name__ == "__main__":
    main()
