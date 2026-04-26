"""
Comparative feedback strengths and stress scenarios.

This script simulates coupled physiological regulation across scenarios and
classifies regulatory performance using illustrative recovery-error thresholds.

Run:
    python python/feedback_scenario_screening.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
SCENARIOS_PATH = ARTICLE_DIR / "data" / "feedback_scenarios.csv"
THRESHOLDS_PATH = ARTICLE_DIR / "data" / "regulatory_thresholds.csv"


def simulate_feedback(
    X0: float = 10,
    X_star: float = 5,
    I_in: float = 0.6,
    a: float = 0.9,
    b: float = 0.5,
    c: float = 0.7,
    d: float = 0.4,
    u0: float = 0.3,
    u1: float = 0.25,
    T: float = 40,
    dt: float = 0.05,
) -> dict[str, float]:
    """Simulate a coupled physiological feedback system."""

    time = np.arange(0, T + dt, dt)

    regulated = np.zeros(len(time))
    hormone = np.zeros(len(time))
    effector = np.zeros(len(time))

    regulated[0] = X0
    hormone[0] = 0
    effector[0] = 0

    for index in range(1, len(time)):
        uptake = u0 + u1 * hormone[index - 1] * regulated[index - 1]

        d_regulated = I_in - uptake
        d_hormone = a * (regulated[index - 1] - X_star) - b * hormone[index - 1]
        d_effector = c * hormone[index - 1] - d * effector[index - 1]

        regulated[index] = max(0.0, regulated[index - 1] + d_regulated * dt)
        hormone[index] = max(0.0, hormone[index - 1] + d_hormone * dt)
        effector[index] = max(0.0, effector[index - 1] + d_effector * dt)

    return {
        "final_X": float(regulated[-1]),
        "peak_X": float(regulated.max()),
        "peak_H": float(hormone.max()),
        "peak_E": float(effector.max()),
        "recovery_error": float(abs(regulated[-1] - X_star)),
    }


def classify_regulation(recovery_error: float, thresholds: dict[str, float]) -> str:
    """Classify regulatory performance from recovery error."""

    if recovery_error < thresholds["recovery_error_well_regulated"]:
        return "well-regulated"

    if recovery_error < thresholds["recovery_error_strained"]:
        return "strained"

    return "poorly-regulated"


def main() -> None:
    """Run feedback scenario screening."""

    scenarios = pd.read_csv(SCENARIOS_PATH)
    threshold_df = pd.read_csv(THRESHOLDS_PATH)
    thresholds = dict(zip(threshold_df["threshold_name"], threshold_df["value"]))

    rows = []

    for _, scenario in scenarios.iterrows():
        result = simulate_feedback(
            X0=scenario["X0"],
            X_star=scenario["X_star"],
            I_in=scenario["I_in"],
            a=scenario["a"],
            b=scenario["b"],
            c=scenario["c"],
            d=scenario["d"],
            u0=scenario["u0"],
            u1=scenario["u1"],
        )

        result["scenario"] = scenario["scenario"]
        rows.append(result)

    output = pd.DataFrame(rows)
    output["regulatory_class"] = output["recovery_error"].apply(
        lambda value: classify_regulation(value, thresholds)
    )

    print(output.round(3).to_string(index=False))


if __name__ == "__main__":
    main()
