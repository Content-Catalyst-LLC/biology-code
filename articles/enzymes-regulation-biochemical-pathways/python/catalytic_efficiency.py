"""
Catalytic efficiency comparison.

Run:
    python python/catalytic_efficiency.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
VARIANTS_PATH = ARTICLE_DIR / "data" / "enzyme_variants.csv"


def main() -> None:
    """Rank enzyme variants by catalytic efficiency."""

    enzymes = pd.read_csv(VARIANTS_PATH)
    enzymes["catalytic_efficiency"] = enzymes["kcat_per_s"] / enzymes["Km_mM"]

    print(
        enzymes.sort_values("catalytic_efficiency", ascending=False)
        .round(4)
        .to_string(index=False)
    )


if __name__ == "__main__":
    main()
