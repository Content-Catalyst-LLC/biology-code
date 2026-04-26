"""
Restoration priority screening for fungal condition.

This script calculates a transparent fungal recovery score using mycorrhizal
inoculum, saprotroph activity, soil connectivity, pathogen pressure, and drought.

Run:
    python python/restoration_priority_screening.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
PRIORITY_PATH = ARTICLE_DIR / "data" / "restoration_priority_sites.csv"


def main() -> None:
    """Calculate fungal restoration recovery scores."""

    sites = pd.read_csv(PRIORITY_PATH)

    sites["recovery_score"] = (
        0.30 * sites["mycorrhizal_inoculum"]
        + 0.25 * sites["saprotroph_activity"]
        + 0.20 * sites["soil_connectivity"]
        + 0.15 * (1 - sites["pathogen_pressure"])
        + 0.10 * (1 - sites["drought_stress"])
    )

    sites["priority_class"] = pd.cut(
        sites["recovery_score"],
        bins=[0, 0.55, 0.70, 1.0],
        labels=["high-intervention", "moderate-intervention", "lower-intervention"],
        include_lowest=True,
    )

    print(
        sites.sort_values("recovery_score", ascending=False)
        .round(3)
        .to_string(index=False)
    )


if __name__ == "__main__":
    main()
