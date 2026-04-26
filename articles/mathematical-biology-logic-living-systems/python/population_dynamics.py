"""
Population dynamics workflows.

Run:
    python python/population_dynamics.py
"""

from pathlib import Path

import numpy as np
import pandas as pd

from math_biology_core import LogisticParameters, logistic_growth


ARTICLE_DIR = Path(__file__).resolve().parents[1]
SCENARIO_PATH = ARTICLE_DIR / "data" / "logistic_scenarios.csv"


def main() -> None:
    scenarios = pd.read_csv(SCENARIO_PATH)

    rows = []

    for _, scenario in scenarios.iterrows():
        time = np.arange(0, scenario["time_end"] + scenario["dt"], scenario["dt"])
        params = LogisticParameters(
            initial_population=float(scenario["initial_population"]),
            growth_rate=float(scenario["growth_rate"]),
            carrying_capacity=float(scenario["carrying_capacity"]),
        )

        population = logistic_growth(time, params)

        rows.append(
            {
                "scenario": scenario["scenario"],
                "final_population": population[-1],
                "fraction_of_capacity": population[-1] / params.carrying_capacity,
                "initial_doubling_time": np.log(2) / params.growth_rate,
            }
        )

    print(pd.DataFrame(rows).round(5).to_string(index=False))


if __name__ == "__main__":
    main()
