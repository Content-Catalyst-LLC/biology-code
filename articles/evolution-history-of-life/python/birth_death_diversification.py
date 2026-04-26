"""
Stochastic birth-death diversification screening.

Run:
    python python/birth_death_diversification.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
SCENARIOS_PATH = ARTICLE_DIR / "data" / "birth_death_scenarios.csv"


def birth_death_sim(
    time_steps: int,
    N0: int,
    lambda_rate: float,
    mu_rate: float,
    n_iter: int,
    seed: int,
) -> pd.DataFrame:
    """Simulate stochastic lineage richness under birth-death logic."""

    rng = np.random.default_rng(seed)
    finals = []
    peaks = []

    for _ in range(n_iter):
        richness = N0
        peak = richness

        for _ in range(time_steps):
            births = rng.poisson(lambda_rate * richness)
            deaths = rng.poisson(mu_rate * richness)
            richness = max(richness + births - deaths, 0)
            peak = max(peak, richness)

            if richness == 0:
                break

        finals.append(richness)
        peaks.append(peak)

    return pd.DataFrame(
        {
            "final_richness": finals,
            "peak_richness": peaks,
        }
    )


def main() -> None:
    """Run birth-death diversification scenarios."""

    scenarios = pd.read_csv(SCENARIOS_PATH)
    summaries = []

    for index, row in scenarios.iterrows():
        result = birth_death_sim(
            time_steps=int(row["time_steps"]),
            N0=int(row["N0"]),
            lambda_rate=row["lambda_rate"],
            mu_rate=row["mu_rate"],
            n_iter=int(row["n_iter"]),
            seed=7 + index,
        )

        summaries.append(
            {
                "scenario": row["scenario"],
                "mean_final_richness": result["final_richness"].mean(),
                "median_final_richness": result["final_richness"].median(),
                "mean_peak_richness": result["peak_richness"].mean(),
                "extinction_probability": (result["final_richness"] == 0).mean(),
            }
        )

    print(pd.DataFrame(summaries).round(4).to_string(index=False))


if __name__ == "__main__":
    main()
