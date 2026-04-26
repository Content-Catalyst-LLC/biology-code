"""
Allele frequency from genotype matrix and Hardy-Weinberg screening.

Run:
    python python/genotype_matrix_hw_screening.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
GENOTYPE_PATH = ARTICLE_DIR / "data" / "genotype_matrix.csv"


def locus_summary(genotypes: np.ndarray) -> dict[str, float]:
    """Estimate allele frequency and Hardy-Weinberg expected counts."""

    n = len(genotypes)
    n_AA = int(np.sum(genotypes == 2))
    n_Aa = int(np.sum(genotypes == 1))
    n_aa = int(np.sum(genotypes == 0))

    p = (2 * n_AA + n_Aa) / (2 * n)
    q = 1 - p

    exp_AA = p**2 * n
    exp_Aa = 2 * p * q * n
    exp_aa = q**2 * n

    chi2 = (
        ((n_AA - exp_AA) ** 2 / exp_AA) if exp_AA > 0 else 0
    ) + (
        ((n_Aa - exp_Aa) ** 2 / exp_Aa) if exp_Aa > 0 else 0
    ) + (
        ((n_aa - exp_aa) ** 2 / exp_aa) if exp_aa > 0 else 0
    )

    return {
        "n": n,
        "p": p,
        "q": q,
        "obs_AA": n_AA,
        "obs_Aa": n_Aa,
        "obs_aa": n_aa,
        "exp_AA": exp_AA,
        "exp_Aa": exp_Aa,
        "exp_aa": exp_aa,
        "chi2_HW": chi2,
    }


def main() -> None:
    """Summarize loci from genotype matrix."""

    genotype_matrix = pd.read_csv(GENOTYPE_PATH)
    locus_columns = [col for col in genotype_matrix.columns if col.startswith("locus_")]

    rows = []

    for locus in locus_columns:
        res = locus_summary(genotype_matrix[locus].to_numpy())
        res["locus"] = locus
        rows.append(res)

    summary_df = pd.DataFrame(rows)

    print(summary_df.round(4).to_string(index=False))


if __name__ == "__main__":
    main()
