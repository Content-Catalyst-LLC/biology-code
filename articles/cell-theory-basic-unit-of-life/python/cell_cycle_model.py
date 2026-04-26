"""
Simplified cell-cycle compartment workflow.

Run:
    python python/cell_cycle_model.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd

from cell_theory_core import simulate_cell_cycle


ARTICLE_DIR = Path(__file__).resolve().parents[1]
CYCLE_PATH = ARTICLE_DIR / "data" / "cell_cycle_scenarios.csv"


def main() -> None:
    """Simulate simplified G1-S-G2M cell-cycle scenarios."""

    scenarios = pd.read_csv(CYCLE_PATH)

    rows = []

    for _, scenario in scenarios.iterrows():
        time = np.arange(0, scenario["time_end"] + scenario["dt"], scenario["dt"])

        sim = simulate_cell_cycle(
            time_h=time,
            g1_initial=scenario["g1_initial"],
            s_initial=scenario["s_initial"],
            g2m_initial=scenario["g2m_initial"],
            k1=scenario["k1"],
            k2=scenario["k2"],
            km=scenario["km"],
        )

        rows.append(
            {
                "scenario": scenario["scenario"],
                "final_G1_fraction": sim["G1"][-1],
                "final_S_fraction": sim["S"][-1],
                "final_G2M_fraction": sim["G2M"][-1],
                "final_total_fraction": sim["G1"][-1] + sim["S"][-1] + sim["G2M"][-1],
            }
        )

    print(pd.DataFrame(rows).round(5).to_string(index=False))


if __name__ == "__main__":
    main()
