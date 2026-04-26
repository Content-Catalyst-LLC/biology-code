"""
Allele frequency summary from genotype counts.

Run:
    python python/allele_frequency_summary.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
GENOTYPE_PATH = ARTICLE_DIR / "data" / "genotype_counts.csv"


def main() -> None:
    """Estimate allele frequencies from genotype counts."""

    df = pd.read_csv(GENOTYPE_PATH)
    counts = dict(zip(df["genotype"], df["count"]))

    n_AA = counts.get("AA", 0)
    n_Aa = counts.get("Aa", 0)
    n_aa = counts.get("aa", 0)
    n = n_AA + n_Aa + n_aa

    p = (2 * n_AA + n_Aa) / (2 * n)
    q = 1 - p
    H_e = 2 * p * q

    observed_het = n_Aa / n

    summary = pd.DataFrame(
        {
            "n": [n],
            "p": [p],
            "q": [q],
            "expected_heterozygosity": [H_e],
            "observed_heterozygosity": [observed_het],
        }
    )

    print(summary.round(4).to_string(index=False))


if __name__ == "__main__":
    main()
