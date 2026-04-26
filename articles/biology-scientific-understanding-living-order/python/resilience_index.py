"""
Perturbation recovery and resilience-index workflow.

Run:
    python python/resilience_index.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd

from living_order_core import homeostatic_solution, recovery_index


ARTICLE_DIR = Path(__file__).resolve().parents[1]
HOME_PATH = ARTICLE_DIR / "data" / "homeostasis_scenarios.csv"


def main() -> None:
    """Calculate recovery indices across homeostasis scenarios."""

    scenarios = pd.read_csv(HOME_PATH)

    rows = []

    for _, scenario in scenarios.iterrows():
        time = np.array([scenario["time_end"]], dtype=float)

        final_state = homeostatic_solution(
            time=time,
            initial_value=scenario["initial_value"],
            setpoint=scenario["setpoint"],
            correction_rate=scenario["correction_rate"],
        )[0]

        index = recovery_index(
            initial_value=scenario["initial_value"],
            final_value=final_state,
            setpoint=scenario["setpoint"],
        )

        rows.append(
            {
                "scenario": scenario["scenario"],
                "initial_deviation": abs(scenario["initial_value"] - scenario["setpoint"]),
                "final_deviation": abs(final_state - scenario["setpoint"]),
                "recovery_index": index,
                "residual_instability": 1 - index,
            }
        )

    print(pd.DataFrame(rows).round(5).to_string(index=False))


if __name__ == "__main__":
    main()
