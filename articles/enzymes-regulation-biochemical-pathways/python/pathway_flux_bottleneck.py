"""
Pathway bottleneck and flux scoring.

Run:
    python python/pathway_flux_bottleneck.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
PATHWAY_PATH = ARTICLE_DIR / "data" / "pathway_steps.csv"


def main() -> None:
    """Estimate simplified pathway flux and identify bottleneck step."""

    pathway = pd.read_csv(PATHWAY_PATH)
    pathway["effective_capacity"] = pathway["capacity"] * pathway["regulation_factor"]

    estimated_flux = pathway["effective_capacity"].min()
    bottleneck = pathway.loc[pathway["effective_capacity"].idxmin()]

    print(pathway.round(3).to_string(index=False))
    print("Estimated pathway flux:", round(float(estimated_flux), 3))
    print("Bottleneck step:", bottleneck["step"], "| enzyme:", bottleneck["enzyme"])


if __name__ == "__main__":
    main()
