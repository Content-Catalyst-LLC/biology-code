"""
Transcript decay and production-decay dynamics.

Run:
    python python/transcript_dynamics.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
DECAY_PATH = ARTICLE_DIR / "data" / "transcript_decay.csv"


def simulate_production_decay(
    t_end: float = 12,
    dt: float = 0.1,
    alpha_base: float = 2,
    alpha_pulse: float = 18,
    pulse_start: float = 2,
    pulse_end: float = 5,
    beta: float = 0.35,
    m0: float = 5,
) -> pd.DataFrame:
    """Simulate production-decay expression dynamics."""

    times = np.arange(0, t_end + dt, dt)
    expression = np.zeros_like(times)
    expression[0] = m0

    for i in range(1, len(times)):
        alpha_t = alpha_pulse if pulse_start <= times[i - 1] <= pulse_end else alpha_base
        dm = alpha_t - beta * expression[i - 1]
        expression[i] = max(expression[i - 1] + dm * dt, 0)

    return pd.DataFrame({"time": times, "expression": expression})


def main() -> None:
    """Fit transcript decay and simulate production-decay dynamics."""

    df = pd.read_csv(DECAY_PATH)
    time_h = df["time_h"].to_numpy(dtype=float)
    expr = df["expression"].to_numpy(dtype=float)

    slope, intercept = np.polyfit(time_h, np.log(expr), 1)

    k_est = -slope
    m0_est = np.exp(intercept)
    half_life_h = np.log(2) / k_est
    auc = np.trapz(expr, time_h)

    summary = pd.DataFrame(
        {
            "k_est": [k_est],
            "m0_est": [m0_est],
            "half_life_h": [half_life_h],
            "AUC": [auc],
        }
    )

    sim = simulate_production_decay()

    print(summary.round(4).to_string(index=False))
    print(sim.head(12).round(4).to_string(index=False))
    print(sim.tail(12).round(4).to_string(index=False))


if __name__ == "__main__":
    main()
