"""
Fungal biomass recovery under disturbance and restoration.

This script models fungal biomass recovery under degraded conditions, mulch,
inoculation, and habitat repair.

Run:
    python python/fungal_biomass_recovery.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
SCENARIOS_PATH = ARTICLE_DIR / "data" / "recovery_scenarios.csv"


def biomass_recovery(
    days: int = 240,
    B0: float = 5.0,
    r: float = 0.05,
    K: float = 80.0,
    m: float = 0.015,
    pulse_day: float | None = None,
    pulse_size: float = 0.0,
    dt: float = 1.0,
) -> pd.DataFrame:
    """Simulate fungal biomass recovery with optional inoculation pulse."""

    time = np.arange(0, days + dt, dt)
    biomass = np.zeros_like(time, dtype=float)
    biomass[0] = B0

    for index in range(1, len(time)):
        inoculum = (
            pulse_size
            if pulse_day is not None and abs(time[index] - pulse_day) < 1e-9
            else 0.0
        )

        d_biomass = (
            r * biomass[index - 1] * (1 - biomass[index - 1] / K)
            - m * biomass[index - 1]
            + inoculum
        ) * dt

        biomass[index] = max(biomass[index - 1] + d_biomass, 0.0)

    return pd.DataFrame({"day": time, "biomass": biomass})


def main() -> None:
    """Run recovery scenarios and print final biomass."""

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

    combined = pd.concat(runs, ignore_index=True)

    summary = (
        combined.groupby("scenario")
        .agg(
            final_biomass=("biomass", "last"),
            peak_biomass=("biomass", "max"),
        )
        .reset_index()
    )

    summary["meets_recovery_target"] = summary["final_biomass"] >= 50

    print(summary.round(3).to_string(index=False))


if __name__ == "__main__":
    main()
