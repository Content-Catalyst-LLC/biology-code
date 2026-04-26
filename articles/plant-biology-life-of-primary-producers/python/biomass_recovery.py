"""
Plant biomass recovery after disturbance.

Run:
    python python/biomass_recovery.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
SCENARIOS_PATH = ARTICLE_DIR / "data" / "biomass_recovery_scenarios.csv"


def biomass_recovery(
    days: int = 365,
    dt: float = 1.0,
    B0: float = 50.0,
    r: float = 0.01,
    K: float = 300.0,
    m: float = 0.002,
    pulse_day: float | None = None,
    pulse_size: float = 0.0,
) -> pd.DataFrame:
    """Simulate plant biomass recovery after disturbance."""

    time = np.arange(0, days + dt, dt)
    biomass = np.zeros_like(time, dtype=float)
    biomass[0] = B0

    for index in range(1, len(time)):
        intervention = (
            pulse_size
            if pulse_day is not None and abs(time[index] - pulse_day) < 1e-9
            else 0.0
        )

        d_biomass = (
            r * biomass[index - 1] * (1 - biomass[index - 1] / K)
            - m * biomass[index - 1]
            + intervention
        ) * dt

        biomass[index] = max(biomass[index - 1] + d_biomass, 0.0)

    return pd.DataFrame({"day": time, "biomass": biomass})


def main() -> None:
    """Run biomass recovery scenarios."""

    scenarios = pd.read_csv(SCENARIOS_PATH)
    runs = []

    for _, row in scenarios.iterrows():
        pulse_day = None if pd.isna(row["pulse_day"]) else float(row["pulse_day"])

        result = biomass_recovery(
            B0=row["B0"],
            r=row["r"],
            K=row["K"],
            m=row["m"],
            pulse_day=pulse_day,
            pulse_size=row["pulse_size"],
        )

        result["scenario"] = row["scenario"]
        runs.append(result)

    results = pd.concat(runs, ignore_index=True)

    summary = (
        results.groupby("scenario")
        .agg(
            final_biomass=("biomass", "last"),
            peak_biomass=("biomass", "max"),
        )
        .reset_index()
    )

    print(summary.round(3).to_string(index=False))


if __name__ == "__main__":
    main()
