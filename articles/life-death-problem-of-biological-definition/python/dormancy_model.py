"""
Dormancy loss and reactivation workflow.

Run:
    python python/dormancy_model.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd

from definition_core import simulate_dormancy


ARTICLE_DIR = Path(__file__).resolve().parents[1]
DORMANCY_PATH = ARTICLE_DIR / "data" / "dormancy_scenarios.csv"


def main() -> None:
    """Simulate dormancy scenarios."""

    scenarios = pd.read_csv(DORMANCY_PATH)

    rows = []

    for _, scenario in scenarios.iterrows():
        time = np.arange(0, scenario["time_end"] + scenario["dt"], scenario["dt"])

        sim = simulate_dormancy(
            time=time,
            dormant_initial=scenario["dormant_initial"],
            active_initial=scenario["active_initial"],
            mortality_rate=scenario["mortality_rate"],
            reactivation_rate=scenario["reactivation_rate"],
        )

        initial_total = scenario["dormant_initial"] + scenario["active_initial"]

        rows.append(
            {
                "scenario": scenario["scenario"],
                "final_dormant": sim["dormant"][-1],
                "final_active": sim["active"][-1],
                "final_dead_or_lost": sim["dead_or_lost"][-1],
                "retained_viable_fraction": (sim["dormant"][-1] + sim["active"][-1]) / initial_total,
                "activated_fraction": sim["active"][-1] / initial_total,
            }
        )

    print(pd.DataFrame(rows).round(5).to_string(index=False))


if __name__ == "__main__":
    main()
