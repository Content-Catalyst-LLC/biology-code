"""
Variant matrix summary: allele frequency, MAF, heterozygosity, and missingness.

Run:
    python python/variant_matrix_summary.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
VARIANT_PATH = ARTICLE_DIR / "data" / "variant_site_summary.csv"


def main() -> None:
    """Summarize population-genomic variant sites."""

    df = pd.read_csv(VARIANT_PATH)

    df["p1"] = df["alt_count_pop1"] / df["n_chrom_pop1"]
    df["p2"] = df["alt_count_pop2"] / df["n_chrom_pop2"]
    df["maf_pop1"] = df["p1"].apply(lambda x: min(x, 1 - x))
    df["maf_pop2"] = df["p2"].apply(lambda x: min(x, 1 - x))
    df["exp_het_pop1"] = 2 * df["p1"] * (1 - df["p1"])
    df["exp_het_pop2"] = 2 * df["p2"] * (1 - df["p2"])
    df["delta_p"] = (df["p1"] - df["p2"]).abs()

    summary = pd.DataFrame(
        {
            "n_loci": [len(df)],
            "mean_maf_pop1": [df["maf_pop1"].mean()],
            "mean_maf_pop2": [df["maf_pop2"].mean()],
            "mean_het_pop1": [df["exp_het_pop1"].mean()],
            "mean_het_pop2": [df["exp_het_pop2"].mean()],
            "mean_missing_rate": [df["missing_rate"].mean()],
        }
    )

    print(summary.round(4).to_string(index=False))
    print(df.sort_values("delta_p", ascending=False).round(4).to_string(index=False))


if __name__ == "__main__":
    main()
