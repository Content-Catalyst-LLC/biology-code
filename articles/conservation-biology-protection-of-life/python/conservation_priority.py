"""
Conservation priority scoring.

This script reads a small conservation-unit dataset and calculates priority
scores using transparent weights. It also performs a simple sensitivity check.

Run:
    python python/conservation_priority.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
DATA_PATH = ARTICLE_DIR / "data" / "conservation_units.csv"


def score_units(data: pd.DataFrame, weights: dict[str, float]) -> pd.DataFrame:
    """Calculate weighted conservation priority scores."""

    scored = data.copy()
    scored["priority_score"] = sum(
        weights[column] * scored[column] for column in weights
    )

    return scored.sort_values("priority_score", ascending=False).reset_index(drop=True)


def main() -> None:
    """Run default and alternative scoring frameworks."""

    units = pd.read_csv(DATA_PATH)

    default_weights = {
        "extinction_risk": 0.30,
        "endemism": 0.20,
        "habitat_loss": 0.20,
        "fragmentation": 0.15,
        "recovery_potential": 0.10,
        "cost_index": -0.05,
    }

    alternative_weights = default_weights.copy()
    alternative_weights["recovery_potential"] = 0.20
    alternative_weights["fragmentation"] = 0.10

    default_ranked = score_units(units, default_weights)
    alternative_ranked = score_units(units, alternative_weights)

    comparison = default_ranked[["unit", "priority_score"]].merge(
        alternative_ranked[["unit", "priority_score"]],
        on="unit",
        suffixes=("_default", "_alternative"),
    )

    comparison["rank_default"] = comparison["priority_score_default"].rank(
        ascending=False,
        method="min",
    )
    comparison["rank_alternative"] = comparison["priority_score_alternative"].rank(
        ascending=False,
        method="min",
    )

    print(comparison.round(3).to_string(index=False))


if __name__ == "__main__":
    main()
