"""
Extinction condition scoring for conservation and systems-risk screening.

Run:
    python python/extinction_condition_scoring.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
SITES_PATH = ARTICLE_DIR / "data" / "extinction_condition_sites.csv"


def condition_class(score: float) -> str:
    """Classify condition from risk-weighted extinction score."""

    if score >= 0.70:
        return "critical"
    if score >= 0.50:
        return "high_concern"
    return "watch"


def main() -> None:
    """Calculate extinction condition score across sites."""

    sites = pd.read_csv(SITES_PATH)

    sites["extinction_condition_score"] = (
        0.22 * sites["lineage_irreplaceability"]
        + 0.20 * sites["range_contraction"]
        + 0.20 * sites["habitat_fragmentation"]
        + 0.18 * sites["functional_uniqueness"]
        + 0.12 * (1 - sites["recovery_potential"])
        + 0.08 * sites["monitoring_confidence"]
    )

    sites["condition_class"] = sites["extinction_condition_score"].apply(condition_class)

    print(
        sites.sort_values("extinction_condition_score", ascending=False)
        .round(3)
        .to_string(index=False)
    )


if __name__ == "__main__":
    main()
