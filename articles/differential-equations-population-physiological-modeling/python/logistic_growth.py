"""
Logistic growth scenarios.

Run:
    python python/logistic_growth.py
"""

from pathlib import Path

import pandas as pd

from differential_equations_core import LogisticParameters, simulate_logistic


ARTICLE_DIR = Path(__file__).resolve().parents[1]
DATA_PATH = ARTICLE_DIR / "data" / "logistic_scenarios.csv"


def main() -> None:
    scenarios = pd.read_csv(DATA_PATH)
    rows = []

    for _, row in scenarios.iterrows():
        params = LogisticParameters(row["N0"], row["r"], row["K"], row["dt"], row["t_end"])
        trajectory = simulate_logistic(params)

        rows.append(
            {
                "scenario": row["scenario"],
                "final_population": trajectory["population"].iloc[-1],
                "fraction_of_capacity": trajectory["population"].iloc[-1] / row["K"],
                "max_population": trajectory["population"].max(),
            }
        )

    print(pd.DataFrame(rows).round(5).to_string(index=False))


if __name__ == "__main__":
    main()
