"""
Mutation-selection-drift simulation with replicates.

Run:
    python python/mutation_selection_drift.py
"""

from __future__ import annotations

import numpy as np
import pandas as pd


def simulate_mut_sel_drift(
    generations: int = 400,
    N: int = 300,
    q0: float = 0.002,
    mu: float = 1e-5,
    s: float = 0.02,
    h: float = 0.5,
    replicates: int = 200,
    seed: int = 7,
) -> pd.DataFrame:
    """Simulate recurrent mutation, selection, and finite-population drift."""

    rng = np.random.default_rng(seed)
    records = []

    for replicate in range(replicates):
        q = q0

        for generation in range(generations + 1):
            records.append(
                {
                    "replicate": replicate,
                    "generation": generation,
                    "q": q,
                    "heterozygosity": 2 * q * (1 - q),
                }
            )

            if generation == generations:
                continue

            p = 1 - q
            w_AA = 1.0
            w_Aa = 1 - h * s
            w_aa = 1 - s

            mean_fitness = p**2 * w_AA + 2 * p * q * w_Aa + q**2 * w_aa
            q_selected = (q**2 * w_aa + p * q * w_Aa) / mean_fitness

            q_mutated = q_selected + (1 - q_selected) * mu
            count_a = rng.binomial(2 * N, q_mutated)
            q = count_a / (2 * N)

    return pd.DataFrame(records)


def main() -> None:
    """Run mutation-selection-drift simulation and summarize outcomes."""

    df = simulate_mut_sel_drift()

    summary = (
        df.groupby("generation")
        .agg(
            mean_q=("q", "mean"),
            sd_q=("q", "std"),
            mean_H=("heterozygosity", "mean"),
        )
        .reset_index()
    )

    finals = df[df["generation"] == df["generation"].max()]

    print(summary.head(10).round(6).to_string(index=False))
    print(summary.tail(10).round(6).to_string(index=False))
    print("Mean final q:", round(float(finals["q"].mean()), 6))
    print("Probability allele lost:", round(float((finals["q"] == 0.0).mean()), 6))


if __name__ == "__main__":
    main()
