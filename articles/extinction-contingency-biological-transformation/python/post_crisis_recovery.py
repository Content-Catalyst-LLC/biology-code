"""
Post-crisis recovery trajectories.

Run:
    python python/post_crisis_recovery.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
RECOVERY_PATH = ARTICLE_DIR / "data" / "recovery_scenarios.csv"


def recovery_curve(time_horizon: int = 30, N0: float = 5, r: float = 0.14, K: float = 60) -> pd.DataFrame:
    """Return a simple post-crisis logistic recovery trajectory."""

    time = np.arange(0, time_horizon + 1)
    richness = K / (1 + ((K - N0) / N0) * np.exp(-r * time))

    return pd.DataFrame({"time": time, "richness": richness})


def main() -> None:
    """Compare recovery scenarios."""

    scenarios = pd.read_csv(RECOVERY_PATH)
    runs = []

    for _, row in scenarios.iterrows():
        result = recovery_curve(
            time_horizon=int(row["time_horizon"]),
            N0=row["N0"],
            r=row["r"],
            K=row["K"],
        )
        result["scenario"] = row["scenario"]
        runs.append(result)

    output = pd.concat(runs, ignore_index=True)

    summary = (
        output.groupby("scenario")
        .agg(final_richness=("richness", "last"))
        .reset_index()
    )

    print(summary.round(3).to_string(index=False))


if __name__ == "__main__":
    main()
