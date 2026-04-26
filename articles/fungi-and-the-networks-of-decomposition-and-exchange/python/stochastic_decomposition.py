"""
Stochastic fungal decomposition simulation.

This script simulates decomposition under variable temperature, moisture,
substrate quality, and fungal guild composition.

Run:
    python python/stochastic_decomposition.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
SITES_PATH = ARTICLE_DIR / "data" / "decomposition_sites.csv"

RNG = np.random.default_rng(42)


def temp_multiplier(temp: float, tref: float = 10.0, q10: float = 2.0) -> float:
    """Return Q10 temperature multiplier."""

    return q10 ** ((temp - tref) / 10.0)


def moisture_multiplier(
    moisture: float,
    m_opt: float = 0.6,
    sigma: float = 0.22,
) -> float:
    """Return unimodal moisture multiplier."""

    return float(np.exp(-((moisture - m_opt) ** 2) / (2 * sigma**2)))


def quality_multiplier(lignin_n: float, slope: float = 0.03) -> float:
    """Return substrate-quality multiplier from lignin:N ratio."""

    return float(np.exp(-slope * lignin_n))


def guild_multiplier(guild: str) -> float:
    """Return simplified fungal guild multiplier."""

    lookup = {
        "white_rot": 1.20,
        "brown_rot": 0.95,
        "mixed_saprotroph": 1.00,
        "disturbance_simplified": 0.72,
    }

    return lookup.get(guild, 1.0)


def simulate_decomposition(
    M0: float = 100.0,
    k0: float = 0.07,
    months: int = 24,
    mean_temp: float = 15.0,
    mean_moisture: float = 0.6,
    lignin_n: float = 16.0,
    guild: str = "mixed_saprotroph",
    temp_sd: float = 2.0,
    moisture_sd: float = 0.12,
) -> pd.DataFrame:
    """Simulate monthly fungal decomposition under stochastic climate."""

    records = []
    mass = M0

    for month in range(months + 1):
        if month == 0:
            records.append(
                {
                    "month": month,
                    "mass_remaining": mass,
                    "mass_lost": 0.0,
                    "temperature": np.nan,
                    "moisture": np.nan,
                    "k_eff": np.nan,
                }
            )
            continue

        temp = float(RNG.normal(mean_temp, temp_sd))
        moisture = float(np.clip(RNG.normal(mean_moisture, moisture_sd), 0.05, 0.98))

        k_eff = (
            k0
            * temp_multiplier(temp)
            * moisture_multiplier(moisture)
            * quality_multiplier(lignin_n)
            * guild_multiplier(guild)
        )

        new_mass = mass * np.exp(-k_eff)

        records.append(
            {
                "month": month,
                "mass_remaining": new_mass,
                "mass_lost": mass - new_mass,
                "temperature": temp,
                "moisture": moisture,
                "k_eff": k_eff,
            }
        )

        mass = new_mass

    return pd.DataFrame(records)


def main() -> None:
    """Compare decomposition across site scenarios."""

    sites = pd.read_csv(SITES_PATH)

    all_runs = []

    for _, site in sites.iterrows():
        result = simulate_decomposition(
            M0=site["M0"],
            k0=site["k0"],
            mean_temp=site["temp"],
            mean_moisture=site["moisture"],
            lignin_n=site["lignin_n"],
            guild=site["guild"],
        )

        result["site"] = site["site"]
        all_runs.append(result)

    results = pd.concat(all_runs, ignore_index=True)

    summary = (
        results.groupby("site")
        .agg(
            final_mass=("mass_remaining", "last"),
            cumulative_loss=("mass_lost", "sum"),
            mean_keff=("k_eff", "mean"),
        )
        .reset_index()
    )

    print(summary.round(3).to_string(index=False))


if __name__ == "__main__":
    main()
