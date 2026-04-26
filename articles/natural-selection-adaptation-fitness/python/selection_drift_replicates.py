"""
Selection-drift replicate simulation.

Run:
    python python/selection_drift_replicates.py
"""

from __future__ import annotations

import numpy as np
import pandas as pd


def simulate_selection_drift(
    generations: int = 200,
    N: int = 300,
    p0: float = 0.4,
    w_AA: float = 1.10,
    w_Aa: float = 1.02,
    w_aa: float = 1.00,
    replicates: int = 200,
    seed: int = 42,
) -> pd.DataFrame:
    """Simulate allele-frequency change under selection and drift."""

    rng = np.random.default_rng(seed)
    records = []

    for replicate in range(replicates):
        p = p0

        for generation in range(generations + 1):
            records.append(
                {
                    "replicate": replicate,
                    "generation": generation,
                    "p": p,
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

            count_A = rng.binomial(2 * N, p_selected)
            p = count_A / (2 * N)

    return pd.DataFrame(records)


def main() -> None:
    """Run selection-drift simulation and summarize outcomes."""

    df = simulate_selection_drift()

    summary = (
        df.groupby("generation")
        .agg(
            mean_p=("p", "mean"),
            sd_p=("p", "std"),
            mean_H=("heterozygosity", "mean"),
        )
        .reset_index()
    )

    finals = df[df["generation"] == df["generation"].max()]

    print(summary.head(10).round(4).to_string(index=False))
    print(summary.tail(10).round(4).to_string(index=False))
    print("Fixation probability:", round(float((finals["p"] == 1.0).mean()), 4))
    print("Loss probability:", round(float((finals["p"] == 0.0).mean()), 4))


if __name__ == "__main__":
    main()
