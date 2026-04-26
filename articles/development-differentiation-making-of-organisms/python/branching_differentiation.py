"""
Branching differentiation dynamics.

Run:
    python python/branching_differentiation.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
SCENARIOS_PATH = ARTICLE_DIR / "data" / "lineage_scenarios.csv"


def simulate_branching_differentiation(
    t_end: float,
    dt: float,
    progenitor0: float,
    k1: float,
    k2: float,
) -> pd.DataFrame:
    """Simulate progenitor decline into two differentiated lineages."""

    times = np.arange(0, t_end + dt, dt)
    progenitor = np.zeros_like(times)
    lineage_1 = np.zeros_like(times)
    lineage_2 = np.zeros_like(times)

    progenitor[0] = progenitor0

    for i in range(1, len(times)):
        dP = -(k1 + k2) * progenitor[i - 1]
        dD1 = k1 * progenitor[i - 1]
        dD2 = k2 * progenitor[i - 1]

        progenitor[i] = max(progenitor[i - 1] + dP * dt, 0)
        lineage_1[i] = lineage_1[i - 1] + dD1 * dt
        lineage_2[i] = lineage_2[i - 1] + dD2 * dt

    return pd.DataFrame(
        {
            "time": times,
            "progenitor": progenitor,
            "lineage_1": lineage_1,
            "lineage_2": lineage_2,
        }
    )


def main() -> None:
    """Run branching differentiation scenarios."""

    scenarios = pd.read_csv(SCENARIOS_PATH)
    summaries = []

    for _, row in scenarios.iterrows():
        result = simulate_branching_differentiation(
            t_end=row["t_end"],
            dt=row["dt"],
            progenitor0=row["progenitor0"],
            k1=row["k1"],
            k2=row["k2"],
        )

        final = result.iloc[-1]

        summaries.append(
            {
                "scenario": row["scenario"],
                "final_progenitor": final["progenitor"],
                "final_lineage_1": final["lineage_1"],
                "final_lineage_2": final["lineage_2"],
                "lineage_1_fraction": final["lineage_1"] / (final["lineage_1"] + final["lineage_2"]),
            }
        )

    print(pd.DataFrame(summaries).round(3).to_string(index=False))


if __name__ == "__main__":
    main()
