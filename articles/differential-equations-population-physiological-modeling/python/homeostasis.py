"""
Physiological homeostasis scenarios.

Run:
    python python/homeostasis.py
"""

from pathlib import Path

import pandas as pd

from differential_equations_core import simulate_homeostasis


ARTICLE_DIR = Path(__file__).resolve().parents[1]
DATA_PATH = ARTICLE_DIR / "data" / "homeostasis_scenarios.csv"


def main() -> None:
    scenarios = pd.read_csv(DATA_PATH)
    rows = []

    for _, row in scenarios.iterrows():
        trajectory = simulate_homeostasis(row["x0"], row["set_point"], row["k"], row["dt"], row["t_end"])

        rows.append(
            {
                "scenario": row["scenario"],
                "initial_state": trajectory["state"].iloc[0],
                "final_state": trajectory["state"].iloc[-1],
                "set_point": row["set_point"],
                "final_absolute_error": abs(trajectory["state"].iloc[-1] - row["set_point"]),
            }
        )

    print(pd.DataFrame(rows).round(5).to_string(index=False))


if __name__ == "__main__":
    main()
