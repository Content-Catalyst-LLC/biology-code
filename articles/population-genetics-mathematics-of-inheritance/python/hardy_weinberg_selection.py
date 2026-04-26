"""
Hardy-Weinberg expectations and genotype-specific selection.

Run:
    python python/hardy_weinberg_selection.py
"""

from __future__ import annotations

import pandas as pd


def hardy_weinberg(p: float) -> dict[str, float]:
    """Return Hardy-Weinberg genotype expectations for a two-allele locus."""

    q = 1 - p

    return {
        "p": p,
        "q": q,
        "expected_AA": p**2,
        "expected_Aa": 2 * p * q,
        "expected_aa": q**2,
        "expected_heterozygosity": 2 * p * q,
    }


def selection_update(
    p: float,
    w_AA: float,
    w_Aa: float,
    w_aa: float,
) -> dict[str, float]:
    """Return one-generation allele-frequency update under genotype-specific fitness."""

    q = 1 - p
    f_AA = p**2
    f_Aa = 2 * p * q
    f_aa = q**2

    mean_fitness = f_AA * w_AA + f_Aa * w_Aa + f_aa * w_aa
    p_next = (f_AA * w_AA + 0.5 * f_Aa * w_Aa) / mean_fitness

    return {
        "p_initial": p,
        "p_next": p_next,
        "delta_p": p_next - p,
        "mean_fitness": mean_fitness,
    }


def main() -> None:
    """Run Hardy-Weinberg and selection examples."""

    hw = hardy_weinberg(0.7)
    update = selection_update(0.2, w_AA=1.15, w_Aa=1.08, w_aa=1.0)

    print(pd.DataFrame([hw]).round(4).to_string(index=False))
    print(pd.DataFrame([update]).round(6).to_string(index=False))


if __name__ == "__main__":
    main()
