"""
Dissolved-oxygen stress screening.

This script applies a compact oxygen balance:

oxygen_change = production - respiration - decomposition - stratification

Run:
    python python/dissolved_oxygen_stress.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
DATA_PATH = ARTICLE_DIR / "data" / "oxygen_stress_sites.csv"


def main() -> None:
    """Calculate oxygen balance and stress class for example sites."""

    sites = pd.read_csv(DATA_PATH)

    sites["oxygen_change"] = (
        sites["oxygen_production"]
        - sites["respiration_demand"]
        - sites["decomposition_demand"]
        - sites["stratification_limitation"]
    )

    sites["projected_oxygen"] = sites["baseline_oxygen"] + sites["oxygen_change"]

    conditions = [
        sites["projected_oxygen"] >= 6.0,
        (sites["projected_oxygen"] >= 3.0) & (sites["projected_oxygen"] < 6.0),
        sites["projected_oxygen"] < 3.0,
    ]

    labels = ["oxygen-supported", "oxygen-stressed", "high-hypoxia-risk"]
    sites["oxygen_risk_class"] = np.select(conditions, labels, default="unknown")

    print(
        sites[
            ["site_id", "oxygen_change", "projected_oxygen", "oxygen_risk_class"]
        ]
        .round(3)
        .to_string(index=False)
    )


if __name__ == "__main__":
    main()
