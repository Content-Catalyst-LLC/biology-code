"""
Homeostatic setpoint dynamics.

Run:
    python python/homeostasis_model.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd

from living_order_core import homeostatic_solution, recovery_index


ARTICLE_DIR = Path(__file__).resolve().parents[1]
HOME_PATH = ARTICLE_DIR / "data" / "homeostasis_scenarios.csv"


def main() -> None:
    """Simulate homeostatic return across scenarios."""

    scenarios = pd.read_csv(HOME_PATH)

    rows = []

    for _, scenario in scenarios.iterrows():
        time = np.arange(0, scenario["time_end"] + scenario["dt"], scenario["dt"])

        state = homeostatic_solution(
            time=time,
            initial_value=scenario["initial_value"],
            setpoint=scenario["setpoint"],
            correction_rate=scenario["correction_rate"],
        )

        rows.append(
            {
                "scenario": scenario["scenario"],
                "initial_value": scenario["initial_value"],
                "setpoint": scenario["setpoint"],
                "correction_rate": scenario["correction_rate"],
                "final_state": state[-1],
                "final_deviation": state[-1] - scenario["setpoint"],
                "half_recovery_time": (
                    np.log(2) / scenario["correction_rate"]
                    if scenario["correction_rate"] > 0
                    else np.nan
                ),
                "recovery_index": recovery_index(
                    scenario["initial_value"],
                    state[-1],
                    scenario["setpoint"],
                ),
            }
        )

    print(pd.DataFrame(rows).round(5).to_string(index=False))


if __name__ == "__main__":
    main()
