"""
QC flag summary workflow.

Run:
    python python/qc_flag_summary.py
"""

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
DATA_PATH = ARTICLE_DIR / "data" / "measurements.csv"


def main() -> None:
    data = pd.read_csv(DATA_PATH)

    summary = (
        data.groupby(["batch_id", "qc_flag"])
        .size()
        .reset_index(name="n_records")
        .sort_values(["batch_id", "qc_flag"])
    )

    total_by_batch = (
        data.groupby("batch_id")
        .size()
        .reset_index(name="batch_total")
    )

    combined = summary.merge(total_by_batch, on="batch_id")
    combined["flag_fraction"] = combined["n_records"] / combined["batch_total"]

    print(combined.round(5).to_string(index=False))


if __name__ == "__main__":
    main()
