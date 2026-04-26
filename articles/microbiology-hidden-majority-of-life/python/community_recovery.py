"""
Microbial community recovery after disturbance.

This script simulates recovery across disturbance and intervention scenarios.

Run:
    python python/community_recovery.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
SCENARIOS_PATH = ARTICLE_DIR / "data" / "community_recovery_scenarios.csv"


def community_recovery(
    days: int = 120,
    dt: float = 1.0,
    B0: float = 10.0,
    r: float = 0.08,
    K: float = 100.0,
    m: float = 0.02,
    pulse_day: float | None = None,
    pulse_size: float = 0.0,
) -> pd.DataFrame:
    """Simulate microbial community recovery after disturbance."""

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
    """Run recovery scenarios and print diagnostics."""

    scenarios = pd.read_csv(SCENARIOS_PATH)
    runs = []

    for _, row in scenarios.iterrows():
        pulse_day = None if pd.isna(row["pulse_day"]) else float(row["pulse_day"])

        result = community_recovery(
            B0=row["B0"],
            r=row["r"],
            K=row["K"],
            m=row["m"],
            pulse_day=pulse_day,
            pulse_size=row["pulse_size"],
        )
        result["scenario"] = row["scenario"]
        runs.append(result)

    recovery = pd.concat(runs, ignore_index=True)

    summary = (
        recovery.groupby("scenario")
        .agg(
            final_biomass=("biomass", "last"),
            peak_biomass=("biomass", "max"),
        )
        .reset_index()
    )

    summary["meets_target"] = summary["final_biomass"] >= 70

    print(summary.round(3).to_string(index=False))


if __name__ == "__main__":
    main()
