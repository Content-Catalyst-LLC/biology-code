"""
Animal condition scoring for conservation screening.

Run:
    python python/animal_condition_scoring.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
SITES_PATH = ARTICLE_DIR / "data" / "animal_condition_sites.csv"


def main() -> None:
    """Calculate animal condition scores for site comparison."""

    sites = pd.read_csv(SITES_PATH)

    sites["animal_condition_score"] = (
        0.24 * sites["habitat_quality"]
        + 0.20 * sites["food_availability"]
        + 0.18 * sites["reproductive_support"]
        + 0.18 * sites["movement_connectivity"]
        + 0.10 * (1 - sites["disease_pressure"])
        + 0.10 * (1 - sites["heat_stress"])
    )

    sites["condition_class"] = pd.cut(
        sites["animal_condition_score"],
        bins=[0, 0.55, 0.72, 1.0],
        labels=["high-concern", "moderate", "strong"],
        include_lowest=True,
    )

    print(
        sites.sort_values("animal_condition_score", ascending=False)
        .round(3)
        .to_string(index=False)
    )


if __name__ == "__main__":
    main()
