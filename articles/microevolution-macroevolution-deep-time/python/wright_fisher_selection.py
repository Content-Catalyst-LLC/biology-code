"""
Wright-Fisher simulation with selection and drift.

Run:
    python python/wright_fisher_selection.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
SCENARIOS_PATH = ARTICLE_DIR / "data" / "population_scenarios.csv"
RNG = np.random.default_rng(42)


def simulate_population(
    generations: int,
    p0: float,
    N: int,
    w_AA: float,
    w_Aa: float,
    w_aa: float,
    mu_A_to_a: float,
    mu_a_to_A: float,
    migration_fraction: float,
    p_migrant: float,
    drift: bool,
) -> pd.DataFrame:
    """Simulate selection, mutation, migration, and optional Wright-Fisher drift."""

    records = []
    p = p0

    for generation in range(generations + 1):
        records.append(
            {
                "generation": generation,
                "p": p,
                "q": 1 - p,
                "heterozygosity": 2 * p * (1 - p),
            }
        )

        if generation == generations:
            continue

        q = 1 - p
        f_AA = p**2
        f_Aa = 2 * p * q
        f_aa = q**2

        mean_fitness = f_AA * w_AA + f_Aa * w_Aa + f_aa * w_aa
        p_selected = (f_AA * w_AA + 0.5 * f_Aa * w_Aa) / mean_fitness

        p_mutated = p_selected * (1 - mu_A_to_a) + (1 - p_selected) * mu_a_to_A
        p_migrated = (1 - migration_fraction) * p_mutated + migration_fraction * p_migrant

        if drift:
            count_A = RNG.binomial(2 * N, p_migrated)
            p = count_A / (2 * N)
        else:
            p = p_migrated

    return pd.DataFrame(records)


def main() -> None:
    """Run all population scenarios and summarize final states."""

    scenarios = pd.read_csv(SCENARIOS_PATH)
    runs = []

    for _, row in scenarios.iterrows():
        result = simulate_population(
            generations=int(row["generations"]),
            p0=row["p0"],
            N=int(row["N"]),
            w_AA=row["W_AA"],
            w_Aa=row["W_Aa"],
            w_aa=row["W_aa"],
            mu_A_to_a=row["mu_A_to_a"],
            mu_a_to_A=row["mu_a_to_A"],
            migration_fraction=row["m"],
            p_migrant=row["p_migrant"],
            drift=str(row["drift"]).lower() == "true",
        )
        result["scenario"] = row["scenario"]
        runs.append(result)

    output = pd.concat(runs, ignore_index=True)

    summary = (
        output.groupby("scenario")
        .agg(
            final_p=("p", "last"),
            final_q=("q", "last"),
            final_heterozygosity=("heterozygosity", "last"),
        )
        .reset_index()
    )

    print(summary.round(4).to_string(index=False))


if __name__ == "__main__":
    main()
