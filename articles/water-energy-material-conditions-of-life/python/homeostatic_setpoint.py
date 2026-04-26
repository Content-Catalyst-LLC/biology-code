"""
Homeostatic setpoint simulation workflow.

Run:
    python python/homeostatic_setpoint.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd

from water_energy_core import homeostatic_solution


ARTICLE_DIR = Path(__file__).resolve().parents[1]
HOMEOSTASIS_PATH = ARTICLE_DIR / "data" / "homeostasis_scenarios.csv"


def main() -> None:
    """Simulate homeostatic return across scenarios."""

    scenarios = pd.read_csv(HOMEOSTASIS_PATH)

    rows = []

    for _, scenario in scenarios.iterrows():
        time = np.arange(0, scenario["time_end"] + scenario["dt"], scenario["dt"])

        state = homeostatic_solution(
            time,
            scenario["initial_value"],
            scenario["setpoint"],
            scenario["correction_rate"],
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
            }
        )

    print(pd.DataFrame(rows).round(5).to_string(index=False))


if __name__ == "__main__":
    main()
