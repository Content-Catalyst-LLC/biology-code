"""
Bootstrap uncertainty workflow.

Run:
    python python/bootstrap_uncertainty.py
"""

from pathlib import Path

import pandas as pd

from probability_core import bootstrap_mean


ARTICLE_DIR = Path(__file__).resolve().parents[1]
MEASURE_PATH = ARTICLE_DIR / "data" / "biological_measurements.csv"


def main() -> None:
    data = pd.read_csv(MEASURE_PATH)

    rows = []

    for group, group_df in data.groupby("group"):
        result = bootstrap_mean(group_df["value"], n_bootstrap=5000, seed=42)

        rows.append(
            {
                "group": group,
                "n": len(group_df),
                **result,
            }
        )

    print(pd.DataFrame(rows).round(5).to_string(index=False))


if __name__ == "__main__":
    main()
