"""
Evolutionary condition scoring.

Run:
    python python/evolutionary_condition_scoring.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
SITES_PATH = ARTICLE_DIR / "data" / "evolutionary_condition_sites.csv"


def condition_class(score: float) -> str:
    """Classify evolutionary condition score."""

    if score >= 0.70:
        return "strong_evolutionary_continuity"
    if score >= 0.50:
        return "moderate_evolutionary_continuity"
    return "constrained_or_at_risk"


def main() -> None:
    """Score evolutionary condition examples."""

    sites = pd.read_csv(SITES_PATH)

    sites["evolutionary_condition_score"] = (
        0.17 * sites["standing_variation"]
        + 0.17 * sites["phylogenetic_signal"]
        + 0.16 * sites["fossil_record_strength"]
        + 0.16 * (1 - sites["environmental_change"])
        + 0.17 * (1 - sites["extinction_pressure"])
        + 0.17 * sites["adaptive_capacity"]
    )

    sites["condition_class"] = sites["evolutionary_condition_score"].apply(condition_class)

    print(
        sites.sort_values("evolutionary_condition_score", ascending=False)
        .round(3)
        .to_string(index=False)
    )


if __name__ == "__main__":
    main()
