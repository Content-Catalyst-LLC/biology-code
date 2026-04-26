"""
Population recovery under intervention scenarios.

Run:
    python python/population_recovery.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
SCENARIOS_PATH = ARTICLE_DIR / "data" / "population_recovery_scenarios.csv"


def logistic_curve(time: np.ndarray, N0: float, r: float, K: float) -> np.ndarray:
    """Return logistic population trajectory."""

    return K / (1 + ((K - N0) / N0) * np.exp(-r * time))


def main() -> None:
    """Compare population recovery scenarios."""

    scenarios = pd.read_csv(SCENARIOS_PATH)
    time = np.arange(0, 51)
    runs = []

    for _, row in scenarios.iterrows():
        abundance = logistic_curve(
            time=time,
            N0=row["N0"],
            r=row["r"],
            K=row["K"],
        )

        result = pd.DataFrame(
            {
                "time": time,
                "abundance": abundance,
                "scenario": row["scenario"],
            }
        )
        runs.append(result)

    results = pd.concat(runs, ignore_index=True)

    summary = (
        results.groupby("scenario")
        .agg(final_population=("abundance", "last"))
        .reset_index()
    )

    print(summary.round(2).to_string(index=False))


if __name__ == "__main__":
    main()
