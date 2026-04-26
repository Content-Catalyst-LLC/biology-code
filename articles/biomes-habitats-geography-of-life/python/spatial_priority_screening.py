"""
Spatial priority screening for habitat and biome workflows.

This script combines habitat suitability, connectivity, disturbance, and
land-use pressure into a transparent priority score.

Run:
    python python/spatial_priority_screening.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
DATA_PATH = ARTICLE_DIR / "data" / "habitat_sites.csv"


def main() -> None:
    """Calculate a transparent spatial priority score."""

    sites = pd.read_csv(DATA_PATH)

    # A compact demonstration score. In real work, replace this with a model
    # calibrated to ecological objectives and stakeholder constraints.
    sites["spatial_priority"] = (
        0.25 * (sites["precipitation"] / sites["precipitation"].max())
        + 0.25 * sites["soil_quality"]
        + 0.25 * sites["connectivity"]
        - 0.15 * sites["disturbance"]
        - 0.10 * sites["land_use_pressure"]
    )

    sites["priority_class"] = pd.cut(
        sites["spatial_priority"],
        bins=[-1, 0.35, 0.55, 1],
        labels=["low", "medium", "high"],
    )

    print(
        sites[
            ["site_id", "spatial_priority", "priority_class"]
        ].sort_values("spatial_priority", ascending=False).round(3).to_string(index=False)
    )


if __name__ == "__main__":
    main()
