"""
Predator-prey workflows.

Run:
    python python/predator_prey.py
"""

from pathlib import Path

import numpy as np
import pandas as pd

from math_biology_core import simulate_predator_prey


ARTICLE_DIR = Path(__file__).resolve().parents[1]
PARAM_PATH = ARTICLE_DIR / "data" / "predator_prey_parameters.csv"


def main() -> None:
    scenarios = pd.read_csv(PARAM_PATH)

    rows = []

    for _, row in scenarios.iterrows():
        sim = simulate_predator_prey(
            prey0=row["prey0"],
            predator0=row["predator0"],
            alpha=row["alpha"],
            beta=row["beta"],
            delta=row["delta"],
            gamma=row["gamma"],
            time_end=row["time_end"],
            dt=row["dt"],
        )

        rows.append(
            {
                "scenario": row["scenario"],
                "final_prey": sim["prey"][-1],
                "final_predator": sim["predator"][-1],
                "max_prey": np.max(sim["prey"]),
                "max_predator": np.max(sim["predator"]),
                "mean_prey": np.mean(sim["prey"]),
                "mean_predator": np.mean(sim["predator"]),
            }
        )

    print(pd.DataFrame(rows).round(4).to_string(index=False))


if __name__ == "__main__":
    main()
