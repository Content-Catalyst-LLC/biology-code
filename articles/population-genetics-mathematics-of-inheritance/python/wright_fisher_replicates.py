"""
Wright-Fisher replicate simulation with fixation and loss statistics.

Run:
    python python/wright_fisher_replicates.py
"""

from __future__ import annotations

import numpy as np
import pandas as pd


def wright_fisher_replicates(
    generations: int = 250,
    N: int = 150,
    p0: float = 0.25,
    w_AA: float = 1.10,
    w_Aa: float = 1.05,
    w_aa: float = 1.0,
    replicates: int = 300,
    seed: int = 42,
) -> pd.DataFrame:
    """Simulate Wright-Fisher allele-frequency trajectories with selection."""

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
    """Run replicate simulation and report fixation/loss statistics."""

    df = wright_fisher_replicates()

    summary = (
        df.groupby("generation")
        .agg(
            mean_p=("p", "mean"),
            sd_p=("p", "std"),
            mean_H=("heterozygosity", "mean"),
        )
        .reset_index()
    )

    finals = df[df["generation"] == df["generation"].max()].copy()
    fixation_prob = (finals["p"] == 1.0).mean()
    loss_prob = (finals["p"] == 0.0).mean()

    print(summary.head(12).round(4).to_string(index=False))
    print(summary.tail(12).round(4).to_string(index=False))
    print(f"Fixation probability: {fixation_prob:.4f}")
    print(f"Loss probability: {loss_prob:.4f}")


if __name__ == "__main__":
    main()
