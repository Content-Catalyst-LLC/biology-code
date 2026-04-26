"""
Expression matrix summary and PCA-style ordination.

Run:
    python python/expression_pca.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
EXPR_PATH = ARTICLE_DIR / "data" / "expression_matrix.csv"
META_PATH = ARTICLE_DIR / "data" / "sample_metadata.csv"


def main() -> None:
    """Summarize expression fold change and compute PCA-style sample coordinates."""

    expr = pd.read_csv(EXPR_PATH).set_index("gene")
    metadata = pd.read_csv(META_PATH)

    control_samples = metadata.loc[metadata["group"] == "control", "sample"].tolist()
    treated_samples = metadata.loc[metadata["group"] == "treated", "sample"].tolist()

    summary = pd.DataFrame(index=expr.index)
    summary["control_mean"] = expr[control_samples].mean(axis=1)
    summary["treated_mean"] = expr[treated_samples].mean(axis=1)
    summary["log2_fc"] = np.log2((summary["treated_mean"] + 1) / (summary["control_mean"] + 1))
    summary["mean_expression"] = (summary["control_mean"] + summary["treated_mean"]) / 2

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

    print(summary.sort_values("log2_fc", ascending=False).round(4).to_string())
    print(pca_df.round(4).to_string(index=False))


if __name__ == "__main__":
    main()
