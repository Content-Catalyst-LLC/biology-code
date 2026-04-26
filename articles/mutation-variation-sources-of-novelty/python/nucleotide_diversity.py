"""
Nucleotide diversity and site-frequency summary.

Run:
    python python/nucleotide_diversity.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
GENOTYPE_PATH = ARTICLE_DIR / "data" / "genotype_site_summary.csv"


def main() -> None:
    """Calculate nucleotide diversity and site-frequency summary."""

    df = pd.read_csv(GENOTYPE_PATH)

    df["p"] = df["derived_count"] / df["n_chromosomes"]
    df["pi_site"] = 2 * df["p"] * (1 - df["p"])
    df["segregating"] = (df["p"] > 0) & (df["p"] < 1)

    summary = pd.DataFrame(
        {
            "n_sites": [len(df)],
            "segregating_sites": [int(df["segregating"].sum())],
            "pi": [df["pi_site"].mean()],
            "mean_derived_frequency": [df["p"].mean()],
        }
    )

    sfs = df.groupby("derived_count").size().reset_index(name="n_sites")

    print(summary.round(5).to_string(index=False))
    print(sfs.to_string(index=False))


if __name__ == "__main__":
    main()
