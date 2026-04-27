"""
Ecology summary cross-check.

Run:
    python python/ecology_summary.py
"""

from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]


def shannon(counts: pd.Series) -> float:
    positive = counts[counts > 0].astype(float)
    proportions = positive / positive.sum()
    return float(-(proportions * np.log(proportions)).sum())


def main() -> None:
    ecology = pd.read_csv(ARTICLE_DIR / "data" / "ecology_counts.csv")

    summary = (
        ecology.groupby(["site", "habitat"])
        .agg(
            total_abundance=("count", "sum"),
            richness=("count", lambda x: int((x > 0).sum())),
            shannon=("count", shannon),
        )
        .reset_index()
        .sort_values("site")
    )

    print(summary.round(5).to_string(index=False))


if __name__ == "__main__":
    main()
