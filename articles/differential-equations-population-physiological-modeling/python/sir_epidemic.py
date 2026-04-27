"""
SIR epidemic scenarios.

Run:
    python python/sir_epidemic.py
"""

from pathlib import Path

import pandas as pd

from differential_equations_core import SIRParameters, simulate_sir


ARTICLE_DIR = Path(__file__).resolve().parents[1]
DATA_PATH = ARTICLE_DIR / "data" / "sir_scenarios.csv"


def main() -> None:
    scenarios = pd.read_csv(DATA_PATH)
    rows = []

    for _, row in scenarios.iterrows():
        params = SIRParameters(
            row["beta"],
            row["gamma"],
            row["S0"],
            row["I0"],
            row["R0"],
            row["dt"],
            row["t_end"],
        )

        trajectory = simulate_sir(params)
        peak_idx = int(trajectory["infected"].idxmax())

        rows.append(
            {
                "scenario": row["scenario"],
                "R0_parameter_ratio": row["beta"] / row["gamma"],
                "peak_infected": trajectory["infected"].iloc[peak_idx],
                "time_to_peak": trajectory["time"].iloc[peak_idx],
                "final_recovered": trajectory["recovered"].iloc[-1],
            }
        )

    print(pd.DataFrame(rows).round(5).to_string(index=False))


if __name__ == "__main__":
    main()
