"""
Organelle morphometry workflow.

Run:
    python python/organelle_morphometry.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd

from cell_architecture_core import organelle_density, organelle_fraction


ARTICLE_DIR = Path(__file__).resolve().parents[1]
MORPH_PATH = ARTICLE_DIR / "data" / "organelle_morphometry.csv"


def main() -> None:
    """Summarize synthetic imaging-style organelle morphometry."""

    df = pd.read_csv(MORPH_PATH)

    df["mitochondrial_fraction"] = [
        organelle_fraction(area, cell_area)
        for area, cell_area in zip(df["mitochondrial_area_um2"], df["cell_area_um2"])
    ]

    df["er_fraction"] = [
        organelle_fraction(area, cell_area)
        for area, cell_area in zip(df["er_area_um2"], df["cell_area_um2"])
    ]

    df["golgi_fraction"] = [
        organelle_fraction(area, cell_area)
        for area, cell_area in zip(df["golgi_area_um2"], df["cell_area_um2"])
    ]

    df["nucleus_fraction"] = [
        organelle_fraction(area, cell_area)
        for area, cell_area in zip(df["nucleus_area_um2"], df["cell_area_um2"])
    ]

    df["lysosome_density"] = [
        organelle_density(count, cell_area)
        for count, cell_area in zip(df["lysosome_count"], df["cell_area_um2"])
    ]

    summary = (
        df.groupby("condition")
        .agg(
            mean_mitochondrial_fraction=("mitochondrial_fraction", "mean"),
            mean_er_fraction=("er_fraction", "mean"),
            mean_golgi_fraction=("golgi_fraction", "mean"),
            mean_nucleus_fraction=("nucleus_fraction", "mean"),
            mean_lysosome_density=("lysosome_density", "mean"),
            n_cells=("cell_id", "count"),
        )
        .reset_index()
    )

    print(df.round(4).to_string(index=False))
    print(summary.round(4).to_string(index=False))


if __name__ == "__main__":
    main()
