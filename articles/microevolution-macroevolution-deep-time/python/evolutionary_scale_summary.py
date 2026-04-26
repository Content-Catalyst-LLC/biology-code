"""
Evolutionary-scale diagnostic summary.

Run:
    python python/evolutionary_scale_summary.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
SITES_PATH = ARTICLE_DIR / "data" / "evolutionary_scale_sites.csv"


def scale_score(row: pd.Series) -> float:
    """Calculate a simple multi-scale evolutionary information score."""

    return (
        0.18 * row["population_variation"]
        + 0.18 * row["lineage_distinctiveness"]
        + 0.16 * row["fossil_record_strength"]
        + 0.16 * row["phylogenetic_resolution"]
        + 0.16 * (1 - row["extinction_pressure"])
        + 0.16 * row["adaptive_capacity"]
    )


def main() -> None:
    """Score examples by multi-scale evolutionary information."""

    sites = pd.read_csv(SITES_PATH)
    sites["evolutionary_scale_score"] = sites.apply(scale_score, axis=1)

    sites["interpretive_class"] = pd.cut(
        sites["evolutionary_scale_score"],
        bins=[0, 0.50, 0.70, 1.00],
        labels=["limited", "moderate", "strong"],
        include_lowest=True,
    )

    print(
        sites.sort_values("evolutionary_scale_score", ascending=False)
        .round(3)
        .to_string(index=False)
    )


if __name__ == "__main__":
    main()
