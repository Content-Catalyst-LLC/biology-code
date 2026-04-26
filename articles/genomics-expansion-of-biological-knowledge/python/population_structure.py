"""
Genome-wide population structure scaffold.

Run:
    python python/population_structure.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
VARIANT_PATH = ARTICLE_DIR / "data" / "variant_site_summary.csv"


def main() -> None:
    """Calculate diversity and FST-style structure from variant summaries."""

    df = pd.read_csv(VARIANT_PATH)

    df["p1"] = df["alt_count_pop1"] / df["n_chrom_pop1"]
    df["p2"] = df["alt_count_pop2"] / df["n_chrom_pop2"]
    df["pbar"] = (df["p1"] + df["p2"]) / 2

    df["pi1"] = 2 * df["p1"] * (1 - df["p1"])
    df["pi2"] = 2 * df["p2"] * (1 - df["p2"])
    df["HT"] = 2 * df["pbar"] * (1 - df["pbar"])
    df["HS"] = (df["pi1"] + df["pi2"]) / 2
    df["fst"] = ((df["HT"] - df["HS"]) / df["HT"]).where(df["HT"] > 0, 0)
    df["delta_p"] = (df["p1"] - df["p2"]).abs()

    summary = pd.DataFrame(
        {
            "mean_pi1": [df["pi1"].mean()],
            "mean_pi2": [df["pi2"].mean()],
            "mean_fst": [df["fst"].mean()],
            "mean_delta_p": [df["delta_p"].mean()],
        }
    )

    print(summary.round(4).to_string(index=False))
    print(df.sort_values("fst", ascending=False).round(4).to_string(index=False))


if __name__ == "__main__":
    main()
