"""
Mixed-effects scaffold without external dependencies.

This script summarizes the structure that a mixed-effects model would analyze.
Production work should use specialized statistical libraries.

Run:
    python python/mixed_effects_scaffold.py
"""

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
DATA_PATH = ARTICLE_DIR / "data" / "biological_technical_replicates.csv"


def main() -> None:
    data = pd.read_csv(DATA_PATH)

    unit_summary = (
        data.groupby("biological_unit")
        .agg(
            n_technical_replicates=("measurement", "count"),
            unit_mean=("measurement", "mean"),
            unit_sd=("measurement", "std"),
        )
        .reset_index()
    )

    overall = pd.DataFrame(
        {
            "grand_mean": [data["measurement"].mean()],
            "n_biological_units": [data["biological_unit"].nunique()],
            "n_total_measurements": [len(data)],
        }
    )

    print(overall.round(5).to_string(index=False))
    print(unit_summary.round(5).to_string(index=False))


if __name__ == "__main__":
    main()
