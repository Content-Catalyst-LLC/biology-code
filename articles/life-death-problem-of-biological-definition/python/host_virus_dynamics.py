"""
Host-virus dynamics workflow.

Run:
    python python/host_virus_dynamics.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd

from definition_core import simulate_host_virus


ARTICLE_DIR = Path(__file__).resolve().parents[1]
VIRUS_PATH = ARTICLE_DIR / "data" / "host_virus_scenarios.csv"


def main() -> None:
    """Simulate host-virus scenarios."""

    scenarios = pd.read_csv(VIRUS_PATH)

    rows = []

    for _, scenario in scenarios.iterrows():
        time = np.arange(0, scenario["time_end"] + scenario["dt"], scenario["dt"])

        sim = simulate_host_virus(
            time=time,
            target_initial=scenario["target_initial"],
            infected_initial=scenario["infected_initial"],
            virus_initial=scenario["virus_initial"],
            beta=scenario["beta"],
            delta=scenario["delta"],
            production=scenario["production"],
            clearance=scenario["clearance"],
        )

        rows.append(
            {
                "scenario": scenario["scenario"],
                "final_target_cells": sim["target_cells"][-1],
                "final_infected_cells": sim["infected_cells"][-1],
                "final_free_virus": sim["free_virus"][-1],
                "peak_infected_cells": sim["infected_cells"].max(),
                "peak_free_virus": sim["free_virus"].max(),
                "time_to_peak_virus": time[sim["free_virus"].argmax()],
            }
        )

    print(pd.DataFrame(rows).round(5).to_string(index=False))


if __name__ == "__main__":
    main()
