"""
Hardy-Weinberg expectations and deterministic selection update.

Run:
    python python/hardy_weinberg_selection.py
"""

from __future__ import annotations

import pandas as pd


def genotype_expectations(p: float) -> dict[str, float]:
    """Return Hardy-Weinberg genotype expectations for a two-allele system."""

    q = 1 - p

    return {
        "p": p,
        "q": q,
        "AA": p**2,
        "Aa": 2 * p * q,
        "aa": q**2,
    }


def selection_update(
    p: float,
    w_AA: float = 1.1,
    w_Aa: float = 1.05,
    w_aa: float = 1.0,
) -> dict[str, float]:
    """Return one-generation allele-frequency update under viability selection."""

    q = 1 - p
    f_AA = p**2
    f_Aa = 2 * p * q
    f_aa = q**2

    mean_fitness = f_AA * w_AA + f_Aa * w_Aa + f_aa * w_aa
    p_next = (f_AA * w_AA + 0.5 * f_Aa * w_Aa) / mean_fitness

    return {
        "p_initial": p,
        "p_next": p_next,
        "mean_fitness": mean_fitness,
        "delta_p": p_next - p,
    }


def main() -> None:
    """Run Hardy-Weinberg and selection examples."""

    hw = genotype_expectations(0.8)
    update = selection_update(0.2, w_AA=1.15, w_Aa=1.08, w_aa=1.0)

    print(pd.DataFrame([hw]).round(4).to_string(index=False))
    print(pd.DataFrame([update]).round(6).to_string(index=False))


if __name__ == "__main__":
    main()
