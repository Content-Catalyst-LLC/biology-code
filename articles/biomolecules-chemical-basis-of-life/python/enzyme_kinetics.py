"""
Michaelis-Menten enzyme kinetics workflow.

Run:
    python python/enzyme_kinetics.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd

from biomolecule_core import michaelis_menten


ARTICLE_DIR = Path(__file__).resolve().parents[1]
ASSAY_PATH = ARTICLE_DIR / "data" / "enzyme_assays.csv"


def main() -> None:
    """Calculate enzyme velocities for assay conditions."""

    assays = pd.read_csv(ASSAY_PATH)

    assays["velocity"] = michaelis_menten(
        assays["substrate_mM"].to_numpy(dtype=float),
        assays["Vmax"].to_numpy(dtype=float),
        assays["Km"].to_numpy(dtype=float),
    )

    assays["fraction_vmax"] = assays["velocity"] / assays["Vmax"]

    print(assays.round(5).to_string(index=False))


if __name__ == "__main__":
    main()
