"""
Differential expression and accessibility summary.

Run:
    python python/differential_expression_accessibility.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
REG_PATH = ARTICLE_DIR / "data" / "expression_accessibility.csv"


def classify_regulatory_pattern(row: pd.Series) -> str:
    """Classify expression/accessibility concordance."""

    if row["log2FC_expr"] > 0 and row["delta_access"] > 0:
        return "up_with_opening"
    if row["log2FC_expr"] < 0 and row["delta_access"] < 0:
        return "down_with_closing"
    return "discordant_or_complex"


def main() -> None:
    """Summarize expression and accessibility change."""

    data = pd.read_csv(REG_PATH)

    data["log2FC_expr"] = np.log2(
        (data["treated_expr"] + 1e-6) /
        (data["control_expr"] + 1e-6)
    )
    data["delta_access"] = data["treated_access"] - data["control_access"]
    data["regulatory_pattern"] = data.apply(classify_regulatory_pattern, axis=1)

    print(data.sort_values("log2FC_expr", ascending=False).round(4).to_string(index=False))


if __name__ == "__main__":
    main()
