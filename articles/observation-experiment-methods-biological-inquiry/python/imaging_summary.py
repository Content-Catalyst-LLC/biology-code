"""
Imaging-feature summary workflow.

Run:
    python python/imaging_summary.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
IMAGE_PATH = ARTICLE_DIR / "data" / "imaging_features.csv"


def main() -> None:
    cells = pd.read_csv(IMAGE_PATH)

    summary = (
        cells.groupby("condition")
        .agg(
            n_cells=("cell_id", "count"),
            mean_area_um2=("area_um2", "mean"),
            sd_area_um2=("area_um2", "std"),
            mean_intensity=("mean_intensity", "mean"),
            mean_roundness=("roundness", "mean"),
        )
        .reset_index()
    )

    print(summary.round(3).to_string(index=False))


if __name__ == "__main__":
    main()
