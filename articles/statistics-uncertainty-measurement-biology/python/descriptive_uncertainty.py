"""
Descriptive uncertainty workflow.

Run:
    python python/descriptive_uncertainty.py
"""

from pathlib import Path

import pandas as pd

from statistics_measurement_core import descriptive_uncertainty


ARTICLE_DIR = Path(__file__).resolve().parents[1]
DATA_PATH = ARTICLE_DIR / "data" / "measurements.csv"


def main() -> None:
    data = pd.read_csv(DATA_PATH)

    rows = []

    for group, group_df in data.groupby("group"):
        summary = descriptive_uncertainty(group_df["value"])

        rows.append(
            {
                "group": group,
                "n": summary.n,
                "mean": summary.mean,
                "standard_deviation": summary.standard_deviation,
                "standard_error": summary.standard_error,
                "ci_lower": summary.ci_lower,
                "ci_upper": summary.ci_upper,
            }
        )

    print(pd.DataFrame(rows).round(5).to_string(index=False))


if __name__ == "__main__":
    main()
