"""
Pathway activation summary.

Run:
    python python/pathway_activation_summary.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
PATHWAY_PATH = ARTICLE_DIR / "data" / "pathway_activation.csv"


def main() -> None:
    """Summarize pathway activation observations by context and pathway."""

    df = pd.read_csv(PATHWAY_PATH)

    context_summary = (
        df.groupby("cell_context")
        .agg(
            mean_activation=("activation_score", "mean"),
            max_activation=("activation_score", "max"),
            n_observations=("activation_score", "size"),
        )
        .reset_index()
        .sort_values("mean_activation", ascending=False)
    )

    pathway_summary = df.sort_values("activation_score", ascending=False)

    print(context_summary.round(4).to_string(index=False))
    print(pathway_summary.round(4).to_string(index=False))


if __name__ == "__main__":
    main()
