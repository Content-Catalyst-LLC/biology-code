"""
Metagenomic abundance and functional-potential summary.

Run:
    python python/metagenomic_profile.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
META_PATH = ARTICLE_DIR / "data" / "metagenomic_profile.csv"


def main() -> None:
    """Summarize metagenomic relative abundance and functional potential."""

    df = pd.read_csv(META_PATH)

    df["relative_abundance"] = df["reads"] / df["reads"].sum()

    df["functional_potential_score"] = (
        0.35 * df["carbon_cycle_genes"] / df["carbon_cycle_genes"].max()
        + 0.35 * df["nitrogen_cycle_genes"] / df["nitrogen_cycle_genes"].max()
        + 0.30 * df["stress_response_genes"] / df["stress_response_genes"].max()
    )

    print(df.sort_values("functional_potential_score", ascending=False).round(4).to_string(index=False))


if __name__ == "__main__":
    main()
