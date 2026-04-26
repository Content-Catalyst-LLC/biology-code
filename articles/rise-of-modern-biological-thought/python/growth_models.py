"""
Growth-model workflows.

Run:
    python python/growth_models.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd

from modern_biology_core import fit_exponential_growth, logistic_growth


ARTICLE_DIR = Path(__file__).resolve().parents[1]
GROWTH_PATH = ARTICLE_DIR / "data" / "growth_observations.csv"
LOGISTIC_PATH = ARTICLE_DIR / "data" / "logistic_scenarios.csv"


def main() -> None:
    growth = pd.read_csv(GROWTH_PATH)

    fit_rows = []

    for scenario, group in growth.groupby("scenario"):
        fit = fit_exponential_growth(
            group["time"].to_numpy(dtype=float),
            group["population"].to_numpy(dtype=float),
        )

        fit_rows.append(
            {
                "scenario": scenario,
                "growth_rate": fit.growth_rate,
                "initial_population": fit.initial_population,
                "doubling_time": fit.doubling_time,
                "r_squared_log_space": fit.r_squared_log_space,
            }
        )

    scenarios = pd.read_csv(LOGISTIC_PATH)

    logistic_rows = []

    for _, scenario in scenarios.iterrows():
        time = np.arange(0, scenario["time_end"] + scenario["dt"], scenario["dt"])

        trajectory = logistic_growth(
            time,
            scenario["initial_population"],
            scenario["growth_rate"],
            scenario["carrying_capacity"],
        )

        logistic_rows.append(
            {
                "scenario": scenario["scenario"],
                "final_population": trajectory[-1],
                "fraction_of_capacity": trajectory[-1] / scenario["carrying_capacity"],
                "initial_doubling_time": np.log(2) / scenario["growth_rate"],
            }
        )

    print(pd.DataFrame(fit_rows).round(5).to_string(index=False))
    print(pd.DataFrame(logistic_rows).round(5).to_string(index=False))


if __name__ == "__main__":
    main()
