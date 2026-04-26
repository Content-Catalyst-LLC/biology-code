"""
Monod growth scenario analysis.

This script simulates substrate-limited microbial growth across rich, poor,
and stressed environments.

Run:
    python python/monod_growth_scenarios.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
SCENARIOS_PATH = ARTICLE_DIR / "data" / "monod_scenarios.csv"


def simulate_monod(
    days: float = 48,
    dt: float = 0.1,
    N0: float = 1e4,
    S0: float = 100.0,
    mu_max: float = 0.8,
    Ks: float = 20.0,
    yield_coeff: float = 1e6,
) -> pd.DataFrame:
    """Simulate substrate-limited microbial growth using Monod kinetics."""

    time = np.arange(0, days + dt, dt)
    abundance = np.zeros_like(time, dtype=float)
    substrate = np.zeros_like(time, dtype=float)

    abundance[0] = N0
    substrate[0] = S0

    for index in range(1, len(time)):
        mu = mu_max * substrate[index - 1] / (Ks + substrate[index - 1])
        d_abundance = mu * abundance[index - 1] * dt
        d_substrate = -(d_abundance / yield_coeff)

        abundance[index] = max(abundance[index - 1] + d_abundance, 0.0)
        substrate[index] = max(substrate[index - 1] + d_substrate, 0.0)

    return pd.DataFrame(
        {
            "time": time,
            "abundance": abundance,
            "substrate": substrate,
        }
    )


def main() -> None:
    """Run Monod growth scenarios."""

    scenarios = pd.read_csv(SCENARIOS_PATH)
    runs = []

    for _, row in scenarios.iterrows():
        result = simulate_monod(
            N0=row["N0"],
            S0=row["S0"],
            mu_max=row["mu_max"],
            Ks=row["Ks"],
            yield_coeff=row["yield_coeff"],
        )
        result["scenario"] = row["scenario"]
        runs.append(result)

    results = pd.concat(runs, ignore_index=True)

    summary = (
        results.groupby("scenario")
        .agg(
            final_abundance=("abundance", "last"),
            remaining_substrate=("substrate", "last"),
            peak_abundance=("abundance", "max"),
        )
        .reset_index()
    )

    print(summary.round(3).to_string(index=False))


if __name__ == "__main__":
    main()
