"""
Mixed-effects design scaffold without external dependencies.

Production mixed-effects inference should use specialized statistical libraries.
This script summarizes nested biological and technical replicate structure.

Run:
    python python/mixed_effects_scaffold.py
"""

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
DATA_PATH = ARTICLE_DIR / "data" / "nested_replicates.csv"


def main() -> None:
    data = pd.read_csv(DATA_PATH)

    unit_summary = (
        data.groupby(["treatment", "biological_unit"])
        .agg(
            n_technical_replicates=("response", "count"),
            unit_mean=("response", "mean"),
            unit_sd=("response", "std"),
        )
        .reset_index()
    )

    treatment_summary = (
        unit_summary.groupby("treatment")
        .agg(
            n_biological_units=("biological_unit", "count"),
            mean_of_unit_means=("unit_mean", "mean"),
            sd_of_unit_means=("unit_mean", "std"),
        )
        .reset_index()
    )

    print(unit_summary.round(5).to_string(index=False))
    print(treatment_summary.round(5).to_string(index=False))


if __name__ == "__main__":
    main()
