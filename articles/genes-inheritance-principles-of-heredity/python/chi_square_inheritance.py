"""
Chi-square inheritance tests for Mendelian ratios.

Run:
    python python/chi_square_inheritance.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
MONO_PATH = ARTICLE_DIR / "data" / "monohybrid_counts.csv"
DI_PATH = ARTICLE_DIR / "data" / "dihybrid_counts.csv"


def chi_square_from_ratio(df: pd.DataFrame) -> tuple[pd.DataFrame, float]:
    """Calculate expected counts and chi-square statistic from expected ratios."""

    total = df["observed"].sum()
    out = df.copy()
    out["expected"] = total * out["expected_ratio"]
    out["chi_component"] = (out["observed"] - out["expected"]) ** 2 / out["expected"]
    chi_square = float(out["chi_component"].sum())
    return out, chi_square


def main() -> None:
    """Run monohybrid and dihybrid chi-square examples."""

    mono = pd.read_csv(MONO_PATH)
    di = pd.read_csv(DI_PATH)

    mono_result, mono_chi = chi_square_from_ratio(mono)
    di_result, di_chi = chi_square_from_ratio(di)

    print("Monohybrid 3:1 test")
    print(mono_result.round(4).to_string(index=False))
    print("chi_square:", round(mono_chi, 4))

    print("\nDihybrid 9:3:3:1 test")
    print(di_result.round(4).to_string(index=False))
    print("chi_square:", round(di_chi, 4))


if __name__ == "__main__":
    main()
