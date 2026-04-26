"""
Structural variation summary and functional-priority screening.

Run:
    python python/structural_variation_summary.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
SV_PATH = ARTICLE_DIR / "data" / "structural_variants.csv"


def main() -> None:
    """Score structural variants for simple functional-priority screening."""

    sv = pd.read_csv(SV_PATH)

    sv["overlaps_gene"] = sv["overlaps_gene"].astype(str).str.lower() == "true"
    sv["overlaps_regulatory_region"] = sv["overlaps_regulatory_region"].astype(str).str.lower() == "true"
    sv["rarity_score"] = 1 - sv["population_frequency"]

    sv["functional_priority_score"] = (
        0.35 * sv["overlaps_gene"].astype(float)
        + 0.30 * sv["overlaps_regulatory_region"].astype(float)
        + 0.20 * sv["rarity_score"]
        + 0.15 * (sv["size_bp"] / sv["size_bp"].max())
    )

    print(sv.sort_values("functional_priority_score", ascending=False).round(4).to_string(index=False))


if __name__ == "__main__":
    main()
