"""
Host-symbiont benefit-cost threshold screening.

Run:
    python python/benefit_cost_threshold.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
SCENARIOS_PATH = ARTICLE_DIR / "data" / "benefit_cost_scenarios.csv"


def relationship_state(net_effect: float) -> str:
    """Classify relationship state from net effect."""

    if net_effect > 0.05:
        return "beneficial"
    if net_effect >= -0.05:
        return "near_neutral"
    return "costly"


def main() -> None:
    """Calculate context-dependent symbiosis outcomes."""

    scenarios = pd.read_csv(SCENARIOS_PATH)

    scenarios["benefit"] = (
        scenarios["benefit_intercept"]
        - scenarios["benefit_stress_slope"] * scenarios["stress"]
    )

    scenarios["cost"] = (
        scenarios["cost_intercept"]
        + scenarios["cost_stress_slope"] * scenarios["stress"]
    )

    scenarios["net_effect"] = (
        scenarios["symbiont_load"]
        * (scenarios["benefit"] - scenarios["cost"])
    )

    scenarios["host_net_performance"] = (
        scenarios["baseline"] + scenarios["net_effect"]
    )

    scenarios["relationship_state"] = scenarios["net_effect"].apply(relationship_state)

    print(
        scenarios[
            [
                "scenario",
                "stress",
                "benefit",
                "cost",
                "net_effect",
                "host_net_performance",
                "relationship_state",
            ]
        ]
        .round(3)
        .to_string(index=False)
    )


if __name__ == "__main__":
    main()
