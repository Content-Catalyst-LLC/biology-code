"""
Growth-model workflows.

Run:
    python python/growth_models.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd

from biological_methods_core import fit_exponential_growth, logistic_growth


ARTICLE_DIR = Path(__file__).resolve().parents[1]
GROWTH_PATH = ARTICLE_DIR / "data" / "growth_observations.csv"
LOGISTIC_PATH = ARTICLE_DIR / "data" / "logistic_scenarios.csv"


def main() -> None:
    growth = pd.read_csv(GROWTH_PATH)

    fit_rows = []
    for condition, group in growth.groupby("condition"):
        fit = fit_exponential_growth(
            group["time_h"].to_numpy(dtype=float),
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

    scenarios = pd.read_csv(LOGISTIC_PATH)
    logistic_rows = []

    for _, scenario in scenarios.iterrows():
        time = np.arange(0, scenario["time_end"] + scenario["dt"], scenario["dt"])
        abundance = logistic_growth(
            time,
            scenario["initial_abundance"],
            scenario["growth_rate"],
            scenario["carrying_capacity"],
        )
        logistic_rows.append(
            {
                "scenario": scenario["scenario"],
                "final_abundance": abundance[-1],
                "fraction_of_capacity": abundance[-1] / scenario["carrying_capacity"],
                "initial_doubling_time": np.log(2) / scenario["growth_rate"],
            }
        )

    print(pd.DataFrame(fit_rows).round(5).to_string(index=False))
    print(pd.DataFrame(logistic_rows).round(5).to_string(index=False))


if __name__ == "__main__":
    main()
