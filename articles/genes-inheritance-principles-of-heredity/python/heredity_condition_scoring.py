"""
Heredity condition scoring.

Run:
    python python/heredity_condition_scoring.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
CONDITION_PATH = ARTICLE_DIR / "data" / "heredity_condition_sites.csv"


def condition_class(score: float) -> str:
    """Classify heredity condition score."""

    if score >= 0.70:
        return "strong_hereditary_resilience"
    if score >= 0.50:
        return "moderate_hereditary_resilience"
    return "constrained_or_high_risk_hereditary_system"


def main() -> None:
    """Score heredity condition examples."""

    sites = pd.read_csv(CONDITION_PATH)

    sites["heredity_condition_score"] = (
        0.18 * sites["standing_variation"]
        + 0.14 * sites["inheritance_clarity"]
        + 0.12 * sites["recombination_information"]
        + 0.15 * sites["population_size"]
        + 0.15 * sites["genotype_quality"]
        + 0.14 * sites["environmental_context"]
        + 0.12 * (1 - sites["inbreeding_risk"])
    )

    sites["condition_class"] = sites["heredity_condition_score"].apply(condition_class)

    print(
        sites.sort_values("heredity_condition_score", ascending=False)
        .round(3)
        .to_string(index=False)
    )


if __name__ == "__main__":
    main()
