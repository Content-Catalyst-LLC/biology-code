"""
Cell-growth model workflows.

Run:
    python python/growth_models.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd

from cell_theory_core import fit_exponential_growth, logistic_growth


ARTICLE_DIR = Path(__file__).resolve().parents[1]
COUNTS_PATH = ARTICLE_DIR / "data" / "cell_counts.csv"
LOGISTIC_PATH = ARTICLE_DIR / "data" / "logistic_scenarios.csv"


def main() -> None:
    """Fit exponential growth and simulate logistic scenarios."""

    counts = pd.read_csv(COUNTS_PATH)

    fit_rows = []

    for condition, group in counts.groupby("condition"):
        fit = fit_exponential_growth(
            group["time_h"].to_numpy(dtype=float),
            group["cells"].to_numpy(dtype=float),
        )

        fit_rows.append(
            {
                "condition": condition,
                "growth_rate_per_h": fit.growth_rate_per_h,
                "initial_count": fit.initial_count,
                "doubling_time_h": fit.doubling_time_h,
                "r_squared_log_space": fit.r_squared_log_space,
            }
        )

    scenarios = pd.read_csv(LOGISTIC_PATH)
    logistic_rows = []

    for _, scenario in scenarios.iterrows():
        time = np.arange(0, scenario["time_end"] + scenario["dt"], scenario["dt"])

        trajectory = logistic_growth(
            time_h=time,
            initial_count=scenario["initial_count"],
            growth_rate=scenario["growth_rate"],
            carrying_capacity=scenario["carrying_capacity"],
        )

        logistic_rows.append(
            {
                "scenario": scenario["scenario"],
                "final_cell_count": trajectory[-1],
                "fraction_of_capacity": trajectory[-1] / scenario["carrying_capacity"],
                "initial_doubling_time_h": np.log(2) / scenario["growth_rate"],
            }
        )

    print(pd.DataFrame(fit_rows).round(5).to_string(index=False))
    print(pd.DataFrame(logistic_rows).round(5).to_string(index=False))


if __name__ == "__main__":
    main()
