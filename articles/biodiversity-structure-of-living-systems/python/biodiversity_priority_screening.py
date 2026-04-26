"""
Biodiversity priority screening.

This script combines effective diversity, richness, fragmentation pressure,
and restoration potential into a transparent site-priority score.

Run:
    python python/biodiversity_priority_screening.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
COMMUNITY_PATH = ARTICLE_DIR / "data" / "community_matrix.csv"
SITE_CONTEXT_PATH = ARTICLE_DIR / "data" / "site_context.csv"


def calculate_hill_q1(community: pd.DataFrame) -> pd.Series:
    """Calculate Hill number q=1, equivalent to exp(Shannon diversity)."""

    relative_abundance = community.div(community.sum(axis=1), axis=0)
    safe_relative_abundance = relative_abundance.replace(0, np.nan)

    shannon = -(
        safe_relative_abundance * np.log(safe_relative_abundance)
    ).sum(axis=1).fillna(0)

    return np.exp(shannon)


def main() -> None:
    """Calculate biodiversity priority scores for example sites."""

    community = pd.read_csv(COMMUNITY_PATH).set_index("site")
    site_context = pd.read_csv(SITE_CONTEXT_PATH).set_index("site")

    screen = pd.DataFrame(index=community.index)
    screen["richness"] = (community > 0).sum(axis=1)
    screen["hill_q1"] = calculate_hill_q1(community)

    screen = screen.join(site_context)

    screen["priority_score"] = (
        0.40 * screen["hill_q1"] / screen["hill_q1"].max()
        + 0.20 * screen["richness"] / screen["richness"].max()
        + 0.25 * screen["fragmentation_pressure"]
        + 0.15 * screen["restoration_potential"]
    )

    screen["priority_class"] = pd.cut(
        screen["priority_score"],
        bins=[-1, 0.45, 0.65, 1.25],
        labels=["lower", "medium", "higher"],
    )

    output = screen.sort_values("priority_score", ascending=False)

    print(
        output[
            [
                "habitat_type",
                "richness",
                "hill_q1",
                "fragmentation_pressure",
                "restoration_potential",
                "priority_score",
                "priority_class",
            ]
        ]
        .round(3)
        .to_string()
    )


if __name__ == "__main__":
    main()
