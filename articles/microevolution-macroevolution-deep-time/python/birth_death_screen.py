"""
Simple birth-death Monte Carlo screening.

Run:
    python python/birth_death_screen.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
SCENARIOS_PATH = ARTICLE_DIR / "data" / "birth_death_scenarios.csv"
RNG = np.random.default_rng(123)


def birth_death_screen(
    n_lineages: int,
    intervals: int,
    lambda_rate: float,
    mu_rate: float,
    n_iter: int,
) -> pd.DataFrame:
    """Simulate simple stochastic macroevolutionary turnover."""

    finals = []

    for _ in range(n_iter):
        lineages = n_lineages

        for _ in range(intervals):
            births = RNG.poisson(lambda_rate * lineages)
            deaths = RNG.poisson(mu_rate * lineages)
            lineages = max(lineages + births - deaths, 0)

            if lineages == 0:
                break

        finals.append(lineages)

    return pd.DataFrame({"final_lineages": finals})


def main() -> None:
    """Run all birth-death scenarios."""

    scenarios = pd.read_csv(SCENARIOS_PATH)
    summaries = []

    for _, row in scenarios.iterrows():
        result = birth_death_screen(
            n_lineages=int(row["n_lineages"]),
            intervals=int(row["intervals"]),
            lambda_rate=row["lambda_rate"],
            mu_rate=row["mu_rate"],
            n_iter=int(row["n_iter"]),
        )

        summaries.append(
            {
                "scenario": row["scenario"],
                "mean_final_lineages": result["final_lineages"].mean(),
                "extinction_probability": (result["final_lineages"] == 0).mean(),
                "median_final_lineages": result["final_lineages"].median(),
            }
        )

    print(pd.DataFrame(summaries).round(4).to_string(index=False))


if __name__ == "__main__":
    main()
