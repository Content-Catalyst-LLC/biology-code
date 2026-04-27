"""
Calculate pathway activity from omics measurements.

Run from article directory:
    python python/04_pathway_activity.py
"""

from pathlib import Path

import pandas as pd

from systems_biology_core import pathway_activity


ARTICLE_DIR = Path(__file__).resolve().parents[1]
EXPRESSION_PATH = ARTICLE_DIR / "data" / "expression.csv"
GENESETS_PATH = ARTICLE_DIR / "data" / "pathway_gene_sets.csv"
OUTPUT_PATH = ARTICLE_DIR / "outputs" / "tables" / "pathway_activity.csv"


def main() -> None:
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)

    expression = pd.read_csv(EXPRESSION_PATH)
    gene_sets = pd.read_csv(GENESETS_PATH)

    activity = pathway_activity(expression, gene_sets)
    activity.to_csv(OUTPUT_PATH, index=False)

    print(activity.round(5).to_string(index=False))
    print(f"Saved: {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
