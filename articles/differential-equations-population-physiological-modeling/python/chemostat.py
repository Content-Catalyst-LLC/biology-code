"""
Chemostat dynamics scenarios.

Run:
    python python/chemostat.py
"""

from pathlib import Path

import pandas as pd

from differential_equations_core import simulate_chemostat


ARTICLE_DIR = Path(__file__).resolve().parents[1]
DATA_PATH = ARTICLE_DIR / "data" / "chemostat_scenarios.csv"


def main() -> None:
    scenarios = pd.read_csv(DATA_PATH)
    rows = []

    for _, row in scenarios.iterrows():
        trajectory = simulate_chemostat(
            X0=row["X0"],
            S0=row["S0"],
            S_in=row["S_in"],
            D=row["D"],
            Y=row["Y"],
            mu_max=row["mu_max"],
            K_s=row["K_s"],
            dt=row["dt"],
            t_end=row["t_end"],
        )

        rows.append(
            {
                "scenario": row["scenario"],
                "final_biomass": trajectory["biomass"].iloc[-1],
                "final_substrate": trajectory["substrate"].iloc[-1],
                "max_biomass": trajectory["biomass"].max(),
                "min_substrate": trajectory["substrate"].min(),
            }
        )

    print(pd.DataFrame(rows).round(5).to_string(index=False))


if __name__ == "__main__":
    main()
