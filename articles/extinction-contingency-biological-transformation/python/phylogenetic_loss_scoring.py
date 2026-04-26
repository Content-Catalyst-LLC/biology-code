"""
Simplified phylogenetic-loss scoring.

Run:
    python python/phylogenetic_loss_scoring.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
PHYLO_PATH = ARTICLE_DIR / "data" / "phylogenetic_loss.csv"


def main() -> None:
    """Calculate simplified fraction of branch length lost."""

    lineages = pd.read_csv(PHYLO_PATH)

    total_history = lineages["branch_length"].sum()
    lost_history = lineages.loc[
        lineages["status"] == "extinct",
        "branch_length",
    ].sum()

    phylogenetic_loss_fraction = lost_history / total_history

    print(f"Total branch length: {total_history:.3f}")
    print(f"Lost branch length: {lost_history:.3f}")
    print(f"Phylogenetic loss fraction: {phylogenetic_loss_fraction:.3f}")


if __name__ == "__main__":
    main()
