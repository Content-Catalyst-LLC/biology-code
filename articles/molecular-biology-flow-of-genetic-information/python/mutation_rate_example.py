"""
Simple mutation-rate examples.

Run:
    python python/mutation_rate_example.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
MUTATION_PATH = ARTICLE_DIR / "data" / "mutation_observations.csv"


def main() -> None:
    """Estimate simple mutation rates from observed counts."""

    df = pd.read_csv(MUTATION_PATH)

    df["mutation_rate"] = (
        df["observed_mutations"] /
        (df["genomes_surveyed"] * df["sites_surveyed"] * df["generations"])
    )

    print(df.sort_values("mutation_rate", ascending=False).to_string(index=False))


if __name__ == "__main__":
    main()
