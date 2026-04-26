"""
Microbial condition scoring for restoration or water-quality monitoring.

This script calculates a transparent condition index from functional richness,
nitrification, denitrification, pathogen signal, and organic overload.

Run:
    python python/microbial_condition_scoring.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
SITES_PATH = ARTICLE_DIR / "data" / "microbial_condition_sites.csv"


def main() -> None:
    """Calculate microbial condition index."""

    sites = pd.read_csv(SITES_PATH)

    sites["microbial_condition_index"] = (
        0.30 * sites["functional_richness"]
        + 0.20 * sites["nitrification_potential"]
        + 0.20 * sites["denitrification_balance"]
        + 0.15 * (1 - sites["pathogen_signal"])
        + 0.15 * (1 - sites["organic_overload"])
    )

    sites["condition_class"] = pd.cut(
        sites["microbial_condition_index"],
        bins=[0, 0.50, 0.70, 1.0],
        labels=["high-concern", "moderate", "strong"],
        include_lowest=True,
    )

    print(
        sites.sort_values("microbial_condition_index", ascending=False)
        .round(3)
        .to_string(index=False)
    )


if __name__ == "__main__":
    main()
