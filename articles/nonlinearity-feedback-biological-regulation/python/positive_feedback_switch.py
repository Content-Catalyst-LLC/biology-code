"""
Positive feedback switch scenarios.

Run:
    python python/positive_feedback_switch.py
"""

from pathlib import Path

import pandas as pd

from nonlinear_feedback_core import PositiveFeedbackParameters, simulate_positive_feedback


ARTICLE_DIR = Path(__file__).resolve().parents[1]
DATA_PATH = ARTICLE_DIR / "data" / "positive_feedback_scenarios.csv"


def main() -> None:
    scenarios = pd.read_csv(DATA_PATH)
    rows = []

    for _, row in scenarios.iterrows():
        trajectory = simulate_positive_feedback(
            PositiveFeedbackParameters(
                x0=row["x0"],
                alpha=row["alpha"],
                beta=row["beta"],
                k_half=row["k_half"],
                hill_coefficient=row["hill_coefficient"],
                dt=row["dt"],
                t_end=row["t_end"],
            )
        )

        rows.append(
            {
                "scenario": row["scenario"],
                "initial_state": trajectory["state"].iloc[0],
                "final_state": trajectory["state"].iloc[-1],
                "max_state": trajectory["state"].max(),
            }
        )

    print(pd.DataFrame(rows).round(5).to_string(index=False))


if __name__ == "__main__":
    main()
