"""
Novelty condition scoring.

Run:
    python python/novelty_condition_scoring.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
CONDITION_PATH = ARTICLE_DIR / "data" / "novelty_condition_sites.csv"


def condition_class(score: float) -> str:
    """Classify novelty condition score."""

    if score >= 0.70:
        return "high_novelty_potential"
    if score >= 0.50:
        return "moderate_novelty_potential"
    return "constrained_or_low_novelty_potential"


def main() -> None:
    """Score novelty condition examples."""

    sites = pd.read_csv(CONDITION_PATH)

    sites["novelty_condition_score"] = (
        0.15 * sites["mutation_supply"]
        + 0.17 * sites["standing_variation"]
        + 0.14 * sites["recombination_potential"]
        + 0.15 * sites["regulatory_flexibility"]
        + 0.15 * sites["developmental_modularity"]
        + 0.14 * sites["ecological_opportunity"]
        + 0.10 * (1 - sites["constraint_risk"])
    )

    sites["condition_class"] = sites["novelty_condition_score"].apply(condition_class)

    print(
        sites.sort_values("novelty_condition_score", ascending=False)
        .round(3)
        .to_string(index=False)
    )


if __name__ == "__main__":
    main()
