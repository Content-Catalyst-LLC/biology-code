"""
Dependency-risk scoring in a mutualistic interaction network.

Run:
    python python/network_dependency_scoring.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
NETWORK_PATH = ARTICLE_DIR / "data" / "network_interactions.csv"


def risk_class(score: float) -> str:
    """Classify dependency risk from weighted support."""

    if score < 0.45:
        return "high_risk"
    if score < 0.65:
        return "moderate_risk"
    return "lower_risk"


def main() -> None:
    """Score dependency support across focal organisms."""

    interactions = pd.read_csv(NETWORK_PATH)
    interactions["weighted_support"] = (
        interactions["weight"] * interactions["partner_reliability"]
    )

    dependency = (
        interactions.groupby("focal")
        .agg(
            dependency_support=("weighted_support", "sum"),
            partner_count=("partner", "count"),
            mean_partner_reliability=("partner_reliability", "mean"),
        )
        .reset_index()
    )

    dependency["risk_class"] = dependency["dependency_support"].apply(risk_class)

    print(dependency.round(3).to_string(index=False))


if __name__ == "__main__":
    main()
