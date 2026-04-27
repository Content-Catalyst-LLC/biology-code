"""
Predator-prey scenarios.

Run:
    python python/predator_prey.py
"""

from pathlib import Path

import pandas as pd

from differential_equations_core import PredatorPreyParameters, simulate_predator_prey


ARTICLE_DIR = Path(__file__).resolve().parents[1]
DATA_PATH = ARTICLE_DIR / "data" / "predator_prey_scenarios.csv"


def main() -> None:
    scenarios = pd.read_csv(DATA_PATH)
    rows = []

    for _, row in scenarios.iterrows():
        params = PredatorPreyParameters(
            row["prey0"],
            row["predator0"],
            row["alpha"],
            row["beta"],
            row["delta"],
            row["gamma"],
            row["dt"],
            row["t_end"],
        )

        trajectory = simulate_predator_prey(params)

        rows.append(
            {
                "scenario": row["scenario"],
                "final_prey": trajectory["prey"].iloc[-1],
                "final_predator": trajectory["predator"].iloc[-1],
                "max_prey": trajectory["prey"].max(),
                "max_predator": trajectory["predator"].max(),
            }
        )

    print(pd.DataFrame(rows).round(5).to_string(index=False))


if __name__ == "__main__":
    main()
