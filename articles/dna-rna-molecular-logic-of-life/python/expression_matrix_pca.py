"""
Expression matrix log2 fold change and PCA-style ordination.

Run:
    python python/expression_matrix_pca.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
EXPR_PATH = ARTICLE_DIR / "data" / "expression_matrix.csv"
META_PATH = ARTICLE_DIR / "data" / "sample_metadata.csv"


def main() -> None:
    """Summarize expression matrix and compute PCA-style coordinates."""

    expr = pd.read_csv(EXPR_PATH).set_index("gene")
    metadata = pd.read_csv(META_PATH)

    control_samples = metadata.loc[metadata["group"] == "control", "sample"].tolist()
    treated_samples = metadata.loc[metadata["group"] == "treated", "sample"].tolist()

    gene_summary = pd.DataFrame(index=expr.index)
    gene_summary["control_mean"] = expr[control_samples].mean(axis=1)
    gene_summary["treated_mean"] = expr[treated_samples].mean(axis=1)
    gene_summary["log2_fc"] = np.log2((gene_summary["treated_mean"] + 1) / (gene_summary["control_mean"] + 1))

    log_expr = np.log2(expr + 1)
    X = log_expr.sub(log_expr.mean(axis=1), axis=0).T.values
    X_centered = X - X.mean(axis=0, keepdims=True)

    U, S, VT = np.linalg.svd(X_centered, full_matrices=False)
    scores = U[:, :2] * S[:2]

    pca_df = pd.DataFrame(
        {
            "sample": log_expr.columns,
            "PC1": scores[:, 0],
            "PC2": scores[:, 1],
        }
    ).merge(metadata, on="sample")

    print(gene_summary.sort_values("log2_fc", ascending=False).round(4).to_string())
    print(pca_df.round(4).to_string(index=False))


if __name__ == "__main__":
    main()
