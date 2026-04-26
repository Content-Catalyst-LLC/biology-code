"""
Allele-frequency evolution under selection, mutation, migration, and drift.

Run:
    python python/allele_frequency_evolution.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
SCENARIOS_PATH = ARTICLE_DIR / "data" / "evolutionary_scenarios.csv"


def simulate_evolution(
    generations: int,
    p0: float,
    N: int,
    w_AA: float,
    w_Aa: float,
    w_aa: float,
    mu: float,
    nu: float,
    migration_fraction: float,
    p_migrant: float,
    drift: bool,
    seed: int,
) -> pd.DataFrame:
    """Simulate selection, mutation, migration, and optional Wright-Fisher drift."""

    rng = np.random.default_rng(seed)
    records = []
    p = p0

    for generation in range(generations + 1):
        q = 1 - p
        records.append(
            {
                "generation": generation,
                "p": p,
                "q": q,
                "expected_heterozygosity": 2 * p * q,
            }
        )

        if generation == generations:
            continue

        f_AA = p**2
        f_Aa = 2 * p * q
        f_aa = q**2

        mean_fitness = f_AA * w_AA + f_Aa * w_Aa + f_aa * w_aa
        p_selected = (f_AA * w_AA + 0.5 * f_Aa * w_Aa) / mean_fitness

        q_selected = 1 - p_selected
        p_mutated = p_selected * (1 - mu) + q_selected * nu
        p_migrated = (1 - migration_fraction) * p_mutated + migration_fraction * p_migrant

        if drift:
            count_A = rng.binomial(2 * N, p_migrated)
            p = count_A / (2 * N)
        else:
            p = p_migrated

    return pd.DataFrame(records)


def main() -> None:
    """Run evolutionary scenarios and summarize final states."""

    scenarios = pd.read_csv(SCENARIOS_PATH)
    summaries = []

    for _, row in scenarios.iterrows():
        result = simulate_evolution(
            generations=int(row["generations"]),
            p0=row["p0"],
            N=int(row["N"]),
            w_AA=row["w_AA"],
            w_Aa=row["w_Aa"],
            w_aa=row["w_aa"],
            mu=row["mu"],
            nu=row["nu"],
            migration_fraction=row["m"],
            p_migrant=row["p_migrant"],
            drift=str(row["drift"]).lower() == "true",
            seed=int(row["seed"]),
        )

        final = result.iloc[-1]

        summaries.append(
            {
                "scenario": row["scenario"],
                "final_p": final["p"],
                "final_q": final["q"],
                "final_expected_heterozygosity": final["expected_heterozygosity"],
            }
        )

    print(pd.DataFrame(summaries).round(4).to_string(index=False))


if __name__ == "__main__":
    main()
