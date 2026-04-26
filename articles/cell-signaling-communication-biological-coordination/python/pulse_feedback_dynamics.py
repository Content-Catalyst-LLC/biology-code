"""
Pulse-driven signaling with negative feedback.

Run:
    python python/pulse_feedback_dynamics.py
"""

from __future__ import annotations

import numpy as np
import pandas as pd


def simulate_feedback() -> pd.DataFrame:
    """Simulate pathway activation and induced negative feedback."""

    times = np.arange(0, 20.1, 0.1)

    pathway_activity = np.zeros_like(times)
    feedback_inhibitor = np.zeros_like(times)

    alpha = 3.0
    beta = 0.6
    gamma = 0.15
    delta = 0.4
    epsilon = 0.3

    input_signal = np.where((times >= 2) & (times <= 8), 1.0, 0.0)

    for i in range(1, len(times)):
        dt = times[i] - times[i - 1]

        dS = (
            alpha * input_signal[i - 1]
            - beta * pathway_activity[i - 1]
            - gamma * feedback_inhibitor[i - 1] * pathway_activity[i - 1]
        )

        dF = delta * pathway_activity[i - 1] - epsilon * feedback_inhibitor[i - 1]

        pathway_activity[i] = max(pathway_activity[i - 1] + dS * dt, 0)
        feedback_inhibitor[i] = max(feedback_inhibitor[i - 1] + dF * dt, 0)

    return pd.DataFrame(
        {
            "time": times,
            "input_signal": input_signal,
            "pathway_activity": pathway_activity,
            "feedback_inhibitor": feedback_inhibitor,
        }
    )


def main() -> None:
    """Run pulse-feedback signaling model."""

    df = simulate_feedback()
    peak = df.loc[df["pathway_activity"].idxmax()]

    print(df.head(15).round(4).to_string(index=False))
    print(df.tail(15).round(4).to_string(index=False))
    print("\nPeak pathway activity:")
    print(peak.round(4).to_string())


if __name__ == "__main__":
    main()
