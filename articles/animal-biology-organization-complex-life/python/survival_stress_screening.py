"""
Survival screening under environmental stress.

Run:
    python python/survival_stress_screening.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
SURVIVAL_PATH = ARTICLE_DIR / "data" / "survival_scenarios.csv"


def survival_curve(days: int = 100, hazard: float = 0.01) -> pd.DataFrame:
    """Return an exponential survival curve."""

    time = np.arange(0, days + 1)
    survival = np.exp(-hazard * time)

    return pd.DataFrame({"day": time, "survival": survival})


def main() -> None:
    """Compare survival under different hazard scenarios."""

    scenarios = pd.read_csv(SURVIVAL_PATH)
    runs = []

    for _, row in scenarios.iterrows():
        result = survival_curve(hazard=row["hazard"])
        result["scenario"] = row["scenario"]
        runs.append(result)

    results = pd.concat(runs, ignore_index=True)

    summary = (
        results.groupby("scenario")
        .agg(
            survival_day_30=("survival", lambda x: x.iloc[30]),
            survival_day_100=("survival", lambda x: x.iloc[100]),
        )
        .reset_index()
    )

    print(summary.round(3).to_string(index=False))


if __name__ == "__main__":
    main()
