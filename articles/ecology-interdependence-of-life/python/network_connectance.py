"""
Ecological network connectance.

This script calculates network connectance from a simple interaction matrix.

Run:
    python python/network_connectance.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
INTERACTION_PATH = ARTICLE_DIR / "data" / "interaction_matrix.csv"


def main() -> None:
    """Calculate basic network metrics from an adjacency matrix."""

    interaction_raw = pd.read_csv(INTERACTION_PATH)
    interaction_matrix = interaction_raw.set_index("species")

    species_count = interaction_matrix.shape[0]
    link_count = int(interaction_matrix.to_numpy().sum())
    connectance = link_count / (species_count ** 2)

    out_degree = interaction_matrix.sum(axis=1)
    in_degree = interaction_matrix.sum(axis=0)

    print("Species count:", species_count)
    print("Link count:", link_count)
    print("Connectance:", round(connectance, 3))

    print("\nOut-degree:")
    print(out_degree.to_string())

    print("\nIn-degree:")
    print(in_degree.to_string())


if __name__ == "__main__":
    main()
