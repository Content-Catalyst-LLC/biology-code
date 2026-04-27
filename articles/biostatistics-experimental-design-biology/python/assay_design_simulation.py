"""
Assay design and plate-layout scaffold.

Run:
    python python/assay_design_simulation.py
"""

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
DATA_PATH = ARTICLE_DIR / "data" / "assay_plate_layout.csv"


def main() -> None:
    layout = pd.read_csv(DATA_PATH)

    treatment_counts = (
        layout.groupby(["block", "treatment"])
        .size()
        .reset_index(name="n_wells")
        .sort_values(["block", "treatment"])
    )

    row_balance = (
        layout.groupby(["row", "treatment"])
        .size()
        .reset_index(name="n_wells")
        .sort_values(["row", "treatment"])
    )

    print(treatment_counts.to_string(index=False))
    print(row_balance.to_string(index=False))


if __name__ == "__main__":
    main()
