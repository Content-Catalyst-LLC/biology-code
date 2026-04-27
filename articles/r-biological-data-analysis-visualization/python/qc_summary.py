"""
Quality-control summary for biological measurements.

Run:
    python python/qc_summary.py
"""

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]


def main() -> None:
    data = pd.read_csv(ARTICLE_DIR / "data" / "measurements.csv")

    summary = (
        data.groupby(["batch_id", "qc_flag"])
        .size()
        .reset_index(name="n_records")
        .sort_values(["batch_id", "qc_flag"])
    )

    batch_totals = data.groupby("batch_id").size().reset_index(name="batch_total")
    summary = summary.merge(batch_totals, on="batch_id")
    summary["flag_fraction"] = summary["n_records"] / summary["batch_total"]

    print(summary.round(5).to_string(index=False))


if __name__ == "__main__":
    main()
