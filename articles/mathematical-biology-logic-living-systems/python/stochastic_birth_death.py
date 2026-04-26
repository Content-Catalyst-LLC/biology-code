"""
Stochastic birth-death workflows.

Run:
    python python/stochastic_birth_death.py
"""

from pathlib import Path

import pandas as pd

from math_biology_core import simulate_birth_death


ARTICLE_DIR = Path(__file__).resolve().parents[1]
SCENARIO_PATH = ARTICLE_DIR / "data" / "stochastic_scenarios.csv"


def main() -> None:
    scenarios = pd.read_csv(SCENARIO_PATH)

    rows = []

    for _, row in scenarios.iterrows():
        trajectory = simulate_birth_death(
            initial_population=int(row["initial_population"]),
            birth_rate=float(row["birth_rate"]),
            death_rate=float(row["death_rate"]),
            time_end=float(row["time_end"]),
            seed=int(row["seed"]),
        )

        final = trajectory[-1]

        rows.append(
            {
                "scenario": row["scenario"],
                "n_events": len(trajectory) - 1,
                "final_time": final["time"],
                "final_population": final["population"],
                "extinct": final["population"] == 0,
            }
        )

    print(pd.DataFrame(rows).round(4).to_string(index=False))


if __name__ == "__main__":
    main()
