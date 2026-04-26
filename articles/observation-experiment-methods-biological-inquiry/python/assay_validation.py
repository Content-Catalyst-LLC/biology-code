"""
Assay-validation workflow.

Run:
    python python/assay_validation.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd

from biological_methods_core import assay_metrics


ARTICLE_DIR = Path(__file__).resolve().parents[1]
ASSAY_PATH = ARTICLE_DIR / "data" / "assay_validation.csv"


def main() -> None:
    assay = pd.read_csv(ASSAY_PATH)

    rows = []

    for _, row in assay.iterrows():
        metrics = assay_metrics(
            int(row["true_positive"]),
            int(row["false_negative"]),
            int(row["true_negative"]),
            int(row["false_positive"]),
        )

        rows.append(
            {
                "assay": row["assay"],
                "sensitivity": metrics.sensitivity,
                "specificity": metrics.specificity,
                "positive_predictive_value": metrics.positive_predictive_value,
                "negative_predictive_value": metrics.negative_predictive_value,
                "accuracy": metrics.accuracy,
            }
        )

    print(pd.DataFrame(rows).round(4).to_string(index=False))


if __name__ == "__main__":
    main()
