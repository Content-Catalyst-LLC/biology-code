"""
Quorum-sensing threshold simulation.

Run:
    python python/quorum_sensing_threshold.py
"""

from __future__ import annotations

import numpy as np
import pandas as pd


def main() -> None:
    """Simulate quorum signal accumulation and threshold activation."""

    times = np.arange(0, 24.1, 0.1)

    population_density = 1e5 * np.exp(0.25 * times)
    population_density = np.minimum(population_density, 1e9)

    Q = np.zeros_like(times)

    a = 1e-9
    d = 0.35
    Qc = 1.0

    for i in range(1, len(times)):
        dt = times[i] - times[i - 1]
        dQ = a * population_density[i - 1] - d * Q[i - 1]
        Q[i] = max(Q[i - 1] + dQ * dt, 0)

    df = pd.DataFrame(
        {
            "time": times,
            "population_density": population_density,
            "quorum_signal": Q,
            "response_active": Q >= Qc,
        }
    )

    first_active = df.loc[df["response_active"]].head(1)

    print(df.head(10).round(4).to_string(index=False))
    print("\nFirst active threshold crossing:")
    print(first_active.round(4).to_string(index=False))


if __name__ == "__main__":
    main()
