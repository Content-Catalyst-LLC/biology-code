"""
Bistability scaffold using a positive-feedback system from multiple initial states.

Run:
    python python/bistability_scaffold.py
"""

import pandas as pd

from nonlinear_feedback_core import PositiveFeedbackParameters, simulate_positive_feedback


def main() -> None:
    initial_states = [0.05, 0.1, 0.5, 1.0, 2.0, 5.0]

    rows = []

    for x0 in initial_states:
        trajectory = simulate_positive_feedback(
            PositiveFeedbackParameters(
                x0=x0,
                alpha=3.0,
                beta=0.8,
                k_half=1.5,
                hill_coefficient=4,
                dt=0.01,
                t_end=80,
            )
        )

        final_state = trajectory["state"].iloc[-1]

        rows.append(
            {
                "initial_state": x0,
                "final_state": final_state,
                "qualitative_state": "high" if final_state > 1 else "low",
            }
        )

    print(pd.DataFrame(rows).round(5).to_string(index=False))


if __name__ == "__main__":
    main()
