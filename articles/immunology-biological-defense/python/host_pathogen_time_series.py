"""
Host-pathogen-immune time series.

This script produces a full time series for a moderate-clearance immune scenario.

Run:
    python python/host_pathogen_time_series.py
"""

from __future__ import annotations

import numpy as np
import pandas as pd


def simulate_time_series(
    P0: float = 50,
    I0: float = 2,
    D0: float = 0,
    r: float = 0.45,
    c: float = 0.12,
    alpha: float = 0.08,
    delta: float = 0.18,
    gamma: float = 0.06,
    rho: float = 0.10,
    T: float = 30,
    dt: float = 0.05,
) -> pd.DataFrame:
    """Return coupled pathogen, immune, and damage time series."""

    time = np.arange(0, T + dt, dt)
    pathogen = np.zeros(len(time))
    immune = np.zeros(len(time))
    damage = np.zeros(len(time))

    pathogen[0], immune[0], damage[0] = P0, I0, D0

    for index in range(1, len(time)):
        d_pathogen = r * pathogen[index - 1] - c * immune[index - 1] * pathogen[index - 1]
        d_immune = alpha * pathogen[index - 1] - delta * immune[index - 1]
        d_damage = gamma * immune[index - 1] - rho * damage[index - 1]

        pathogen[index] = max(0.0, pathogen[index - 1] + d_pathogen * dt)
        immune[index] = max(0.0, immune[index - 1] + d_immune * dt)
        damage[index] = max(0.0, damage[index - 1] + d_damage * dt)

    return pd.DataFrame(
        {
            "time": time,
            "pathogen_load": pathogen,
            "immune_activity": immune,
            "damage_burden": damage,
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
                "peak_pathogen": output["pathogen_load"].max(),
                "peak_immune": output["immune_activity"].max(),
                "peak_damage": output["damage_burden"].max(),
                "final_pathogen": output["pathogen_load"].iloc[-1],
                "final_damage": output["damage_burden"].iloc[-1],
            }
        ).round(3)
    )


if __name__ == "__main__":
    main()
