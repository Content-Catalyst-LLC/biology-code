"""
One-compartment pharmacokinetic scenarios.

Run:
    python python/pharmacokinetics.py
"""

from pathlib import Path
import math

import pandas as pd

from differential_equations_core import simulate_one_compartment


ARTICLE_DIR = Path(__file__).resolve().parents[1]
DATA_PATH = ARTICLE_DIR / "data" / "pharmacokinetic_scenarios.csv"


def main() -> None:
    scenarios = pd.read_csv(DATA_PATH)
    rows = []

    for _, row in scenarios.iterrows():
        trajectory = simulate_one_compartment(row["C0"], row["elimination_rate"], row["dt"], row["t_end"])

        rows.append(
            {
                "scenario": row["scenario"],
                "initial_concentration": trajectory["concentration"].iloc[0],
                "final_concentration": trajectory["concentration"].iloc[-1],
                "elimination_rate": row["elimination_rate"],
                "half_life": math.log(2) / row["elimination_rate"],
            }
        )

    print(pd.DataFrame(rows).round(5).to_string(index=False))


if __name__ == "__main__":
    main()
