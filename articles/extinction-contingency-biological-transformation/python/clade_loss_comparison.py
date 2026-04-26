"""
Clade-level survivorship and extinction comparison.

Run:
    python python/clade_loss_comparison.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
CLADE_PATH = ARTICLE_DIR / "data" / "clade_survivorship.csv"


def main() -> None:
    """Calculate survivorship and extinction proportions across clades."""

    clades = pd.read_csv(CLADE_PATH)

    clades["loss_count"] = clades["initial"] - clades["survivors"]
    clades["survivorship"] = clades["survivors"] / clades["initial"]
    clades["extinction"] = 1 - clades["survivorship"]

    print(
        clades.sort_values("extinction", ascending=False)
        .round(4)
        .to_string(index=False)
    )


if __name__ == "__main__":
    main()
