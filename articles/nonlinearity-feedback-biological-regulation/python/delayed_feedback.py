"""
Delayed negative feedback scenarios.

Run:
    python python/delayed_feedback.py
"""

from pathlib import Path

import pandas as pd

from nonlinear_feedback_core import simulate_delayed_negative_feedback


ARTICLE_DIR = Path(__file__).resolve().parents[1]
DATA_PATH = ARTICLE_DIR / "data" / "delayed_feedback_scenarios.csv"


def main() -> None:
    scenarios = pd.read_csv(DATA_PATH)
    rows = []

    for _, row in scenarios.iterrows():
        trajectory = simulate_delayed_negative_feedback(
            x0=row["x0"],
            production_rate=row["production_rate"],
            feedback_strength=row["feedback_strength"],
            delay=row["delay"],
            dt=row["dt"],
            t_end=row["t_end"],
        )

        rows.append(
            {
                "scenario": row["scenario"],
                "delay": row["delay"],
                "final_state": trajectory["state"].iloc[-1],
                "max_state": trajectory["state"].max(),
                "state_range": trajectory["state"].max() - trajectory["state"].min(),
            }
        )

    print(pd.DataFrame(rows).round(5).to_string(index=False))


if __name__ == "__main__":
    main()
