"""
Assay quality-control summary workflow.

Run:
    python python/assay_quality_control.py
"""

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
DATA_PATH = ARTICLE_DIR / "data" / "assay_qc.csv"


def coefficient_of_variation(series):
    return series.std(ddof=1) / series.mean()


def main() -> None:
    qc = pd.read_csv(DATA_PATH)

    rows = []

    for column in ["control_low", "control_high", "blank_response", "positive_control"]:
        rows.append(
            {
                "measure": column,
                "mean": qc[column].mean(),
                "sd": qc[column].std(ddof=1),
                "cv": coefficient_of_variation(qc[column]),
                "min": qc[column].min(),
                "max": qc[column].max(),
            }
        )

    print(pd.DataFrame(rows).round(5).to_string(index=False))


if __name__ == "__main__":
    main()
