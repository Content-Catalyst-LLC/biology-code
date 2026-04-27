"""
Logistic density-dependent regulation scenarios.

Run:
    python python/logistic_regulation.py
"""

from pathlib import Path

import pandas as pd

from nonlinear_feedback_core import simulate_logistic


ARTICLE_DIR = Path(__file__).resolve().parents[1]
DATA_PATH = ARTICLE_DIR / "data" / "logistic_regulation_scenarios.csv"


def main() -> None:
    scenarios = pd.read_csv(DATA_PATH)
    rows = []

    for _, row in scenarios.iterrows():
        trajectory = simulate_logistic(row["N0"], row["r"], row["K"], row["dt"], row["t_end"])

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
