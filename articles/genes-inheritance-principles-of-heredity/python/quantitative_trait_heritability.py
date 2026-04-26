"""
Quantitative trait and heritability scaffold.

Run:
    python python/quantitative_trait_heritability.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
QT_PATH = ARTICLE_DIR / "data" / "quantitative_trait.csv"


def main() -> None:
    """Estimate simple variance components and selection response."""

    df = pd.read_csv(QT_PATH)

    VA = df["additive_genetic_value"].var(ddof=1)
    VP = df["phenotype"].var(ddof=1)
    h2 = VA / VP

    selection_threshold = df["phenotype"].quantile(0.80)
    selected = df["phenotype"] >= selection_threshold

    S = df.loc[selected, "phenotype"].mean() - df["phenotype"].mean()
    R = h2 * S

    summary = pd.DataFrame(
        {
            "additive_variance": [VA],
            "phenotypic_variance": [VP],
            "h2": [h2],
            "selection_differential": [S],
            "predicted_response": [R],
        }
    )

    print(summary.round(4).to_string(index=False))


if __name__ == "__main__":
    main()
