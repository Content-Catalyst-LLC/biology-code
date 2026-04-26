"""
Hawk-Dove conflict model.

This script calculates expected payoffs for Hawk and Dove strategies under
different resource values, conflict costs, and strategy frequencies.

Run:
    python python/hawk_dove_conflict.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
PARAMETERS_PATH = ARTICLE_DIR / "data" / "hawk_dove_parameters.csv"


def hawk_dove_payoffs(
    resource_value: float,
    conflict_cost: float,
    hawk_frequency: float,
) -> tuple[float, float]:
    """Return expected Hawk and Dove payoffs."""

    dove_frequency = 1.0 - hawk_frequency

    payoff_hawk_against_hawk = (resource_value - conflict_cost) / 2.0
    payoff_hawk_against_dove = resource_value
    payoff_dove_against_hawk = 0.0
    payoff_dove_against_dove = resource_value / 2.0

    expected_hawk = (
        hawk_frequency * payoff_hawk_against_hawk
        + dove_frequency * payoff_hawk_against_dove
    )

    expected_dove = (
        hawk_frequency * payoff_dove_against_hawk
        + dove_frequency * payoff_dove_against_dove
    )

    return expected_hawk, expected_dove


def main() -> None:
    """Compare Hawk-Dove scenarios."""

    parameters = pd.read_csv(PARAMETERS_PATH)

    rows = []
    for _, row in parameters.iterrows():
        expected_hawk, expected_dove = hawk_dove_payoffs(
            resource_value=row["resource_value"],
            conflict_cost=row["conflict_cost"],
            hawk_frequency=row["hawk_frequency"],
        )

        rows.append(
            {
                "scenario": row["scenario"],
                "resource_value": row["resource_value"],
                "conflict_cost": row["conflict_cost"],
                "hawk_frequency": row["hawk_frequency"],
                "expected_hawk": expected_hawk,
                "expected_dove": expected_dove,
                "advantaged_strategy": (
                    "hawk" if expected_hawk > expected_dove else "dove"
                ),
            }
        )

    print(pd.DataFrame(rows).round(3).to_string(index=False))


if __name__ == "__main__":
    main()
