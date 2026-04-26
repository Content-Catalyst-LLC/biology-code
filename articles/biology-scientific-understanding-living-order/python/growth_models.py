"""
Growth models for living order.

Run:
    python python/growth_models.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd

from living_order_core import fit_exponential_growth, logistic_growth


ARTICLE_DIR = Path(__file__).resolve().parents[1]
GROWTH_PATH = ARTICLE_DIR / "data" / "growth_observations.csv"
LOGISTIC_PATH = ARTICLE_DIR / "data" / "logistic_scenarios.csv"


def main() -> None:
    """Fit exponential growth and simulate logistic constraint scenarios."""

    growth = pd.read_csv(GROWTH_PATH)

    fit_rows = []

    for condition, group in growth.groupby("condition"):
        fit = fit_exponential_growth(
            group["time"].to_numpy(dtype=float),
            group["abundance"].to_numpy(dtype=float),
        )

        fit_rows.append(
            {
                "condition": condition,
                "growth_rate": fit.growth_rate,
                "initial_abundance": fit.initial_abundance,
                "doubling_time": fit.doubling_time,
                "r_squared_log_space": fit.r_squared_log_space,
            }
        )

    logistic_scenarios = pd.read_csv(LOGISTIC_PATH)

    summary_rows = []

    for _, scenario in logistic_scenarios.iterrows():
        time = np.arange(0, scenario["time_end"] + scenario["dt"], scenario["dt"])

        trajectory = logistic_growth(
            time=time,
            initial_abundance=scenario["initial_abundance"],
            growth_rate=scenario["growth_rate"],
            carrying_capacity=scenario["carrying_capacity"],
        )

        summary_rows.append(
            {
                "scenario": scenario["scenario"],
                "initial_abundance": scenario["initial_abundance"],
                "growth_rate": scenario["growth_rate"],
                "carrying_capacity": scenario["carrying_capacity"],
                "final_abundance": trajectory[-1],
                "fraction_of_capacity": trajectory[-1] / scenario["carrying_capacity"],
            }
        )

    print(pd.DataFrame(fit_rows).round(5).to_string(index=False))
    print(pd.DataFrame(summary_rows).round(5).to_string(index=False))


if __name__ == "__main__":
    main()
