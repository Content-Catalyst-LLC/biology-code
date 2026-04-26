"""
SIR epidemic model workflows.

Run:
    python python/epidemic_models.py
"""

from pathlib import Path

import numpy as np
import pandas as pd

from math_biology_core import SIRParameters, simulate_sir


ARTICLE_DIR = Path(__file__).resolve().parents[1]
SIR_PATH = ARTICLE_DIR / "data" / "sir_scenarios.csv"


def main() -> None:
    scenarios = pd.read_csv(SIR_PATH)

    rows = []

    for _, row in scenarios.iterrows():
        params = SIRParameters(
            beta=row["beta"],
            gamma=row["gamma"],
            susceptible0=row["susceptible0"],
            infected0=row["infected0"],
            recovered0=row["recovered0"],
        )

        sim = simulate_sir(params, time_end=row["time_end"], dt=row["dt"])

        peak_idx = int(np.argmax(sim["infected"]))

        rows.append(
            {
                "scenario": row["scenario"],
                "R0": row["beta"] / row["gamma"],
                "peak_infected": sim["infected"][peak_idx],
                "time_to_peak": sim["time"][peak_idx],
                "final_recovered": sim["recovered"][-1],
            }
        )

    print(pd.DataFrame(rows).round(5).to_string(index=False))


if __name__ == "__main__":
    main()
