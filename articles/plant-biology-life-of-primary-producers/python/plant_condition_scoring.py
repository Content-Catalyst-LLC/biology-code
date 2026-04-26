"""
Plant condition scoring for restoration and vegetation monitoring.

Run:
    python python/plant_condition_scoring.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
SITES_PATH = ARTICLE_DIR / "data" / "plant_condition_sites.csv"


def main() -> None:
    """Calculate plant condition score across sites."""

    sites = pd.read_csv(SITES_PATH)

    sites["plant_condition_score"] = (
        0.20 * sites["canopy_condition"]
        + 0.18 * sites["water_availability"]
        + 0.16 * sites["nutrient_status"]
        + 0.16 * sites["soil_function"]
        + 0.15 * sites["regeneration_support"]
        + 0.08 * (1 - sites["disease_pressure"])
        + 0.07 * (1 - sites["drought_stress"])
    )

    sites["condition_class"] = pd.cut(
        sites["plant_condition_score"],
        bins=[0, 0.55, 0.72, 1.0],
        labels=["high-concern", "moderate", "strong"],
        include_lowest=True,
    )

    print(
        sites.sort_values("plant_condition_score", ascending=False)
        .round(3)
        .to_string(index=False)
    )


if __name__ == "__main__":
    main()
