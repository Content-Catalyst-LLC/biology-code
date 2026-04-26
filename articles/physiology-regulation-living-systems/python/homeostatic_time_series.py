"""
Homeostatic time series for coupled physiological regulation.

This script produces a full time series for the moderate-feedback scenario.

Run:
    python python/homeostatic_time_series.py
"""

from __future__ import annotations

import numpy as np
import pandas as pd


def simulate_time_series(
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
) -> pd.DataFrame:
    """Return coupled regulated-variable, hormone, and effector time series."""

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

    return pd.DataFrame(
        {
            "time": time,
            "regulated_variable": regulated,
            "hormonal_signal": hormone,
            "effector_response": effector,
        }
    )


def main() -> None:
    """Print representative time series and diagnostics."""

    output = simulate_time_series()

    print(output.head(20).round(3).to_string(index=False))
    print("\nDiagnostics:")
    print(
        pd.Series(
            {
                "peak_X": output["regulated_variable"].max(),
                "peak_H": output["hormonal_signal"].max(),
                "peak_E": output["effector_response"].max(),
                "final_X": output["regulated_variable"].iloc[-1],
                "recovery_error": abs(output["regulated_variable"].iloc[-1] - 5),
            }
        ).round(3)
    )


if __name__ == "__main__":
    main()
