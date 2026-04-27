"""
Negative feedback homeostasis scenarios.

Run:
    python python/negative_feedback.py
"""

from pathlib import Path

import pandas as pd

from nonlinear_feedback_core import NegativeFeedbackParameters, simulate_negative_feedback


ARTICLE_DIR = Path(__file__).resolve().parents[1]
DATA_PATH = ARTICLE_DIR / "data" / "negative_feedback_scenarios.csv"


def main() -> None:
    scenarios = pd.read_csv(DATA_PATH)
    rows = []

    for _, row in scenarios.iterrows():
        trajectory = simulate_negative_feedback(
            NegativeFeedbackParameters(
                x0=row["x0"],
                set_point=row["set_point"],
                k=row["k"],
                dt=row["dt"],
                t_end=row["t_end"],
            )
        )

        rows.append(
            {
                "scenario": row["scenario"],
                "initial_state": trajectory["state"].iloc[0],
                "final_state": trajectory["state"].iloc[-1],
                "set_point": row["set_point"],
                "final_error": abs(trajectory["state"].iloc[-1] - row["set_point"]),
            }
        )

    print(pd.DataFrame(rows).round(5).to_string(index=False))


if __name__ == "__main__":
    main()
