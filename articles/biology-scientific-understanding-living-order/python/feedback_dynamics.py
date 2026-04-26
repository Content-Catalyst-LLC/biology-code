"""
Feedback dynamics workflow.

Run:
    python python/feedback_dynamics.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd

from living_order_core import feedback_response


ARTICLE_DIR = Path(__file__).resolve().parents[1]
FEEDBACK_PATH = ARTICLE_DIR / "data" / "feedback_scenarios.csv"


def main() -> None:
    """Calculate corrective response for feedback scenarios."""

    feedback = pd.read_csv(FEEDBACK_PATH)

    feedback["deviation"] = feedback["state"] - feedback["setpoint"]
    feedback["corrective_response"] = [
        feedback_response(state, setpoint, gain)
        for state, setpoint, gain in zip(
            feedback["state"],
            feedback["setpoint"],
            feedback["feedback_gain"],
        )
    ]

    feedback["absolute_response"] = feedback["corrective_response"].abs()

    print(feedback.round(5).to_string(index=False))


if __name__ == "__main__":
    main()
