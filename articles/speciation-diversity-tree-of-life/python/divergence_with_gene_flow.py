"""
Divergence-with-gene-flow simulation across many loci.

Run:
    python python/divergence_with_gene_flow.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
SCENARIOS_PATH = ARTICLE_DIR / "data" / "divergence_scenarios.csv"


def simulate_divergence(
    generations: int,
    loci: int,
    N1: int,
    N2: int,
    m12: float,
    m21: float,
    sel_sd: float,
    seed: int,
) -> pd.DataFrame:
    """Simulate divergence between two populations with limited migration."""

    rng = np.random.default_rng(seed)

    p1 = rng.uniform(0.2, 0.8, size=loci)
    p2 = p1.copy()

    s1 = rng.normal(0, sel_sd, size=loci)
    s2 = -s1

    records = []

    for generation in range(generations + 1):
        H1 = 2 * p1 * (1 - p1)
        H2 = 2 * p2 * (1 - p2)
        pbar = (p1 + p2) / 2
        HT = 2 * pbar * (1 - pbar)
        HS = (H1 + H2) / 2
        fst = np.where(HT > 0, (HT - HS) / HT, 0)

        records.append(
            pd.DataFrame(
                {
                    "generation": generation,
                    "locus": np.arange(loci),
                    "p1": p1,
                    "p2": p2,
                    "delta_p": np.abs(p1 - p2),
                    "fst": fst,
                }
            )
        )

        if generation == generations:
            break

        p1_sel = np.clip(p1 + s1 * p1 * (1 - p1), 0, 1)
        p2_sel = np.clip(p2 + s2 * p2 * (1 - p2), 0, 1)

        p1_mig = (1 - m12) * p1_sel + m12 * p2_sel
        p2_mig = (1 - m21) * p2_sel + m21 * p1_sel

        p1 = rng.binomial(2 * N1, p1_mig) / (2 * N1)
        p2 = rng.binomial(2 * N2, p2_mig) / (2 * N2)

    return pd.concat(records, ignore_index=True)


def main() -> None:
    """Run divergence scenarios and summarize final differentiation."""

    scenarios = pd.read_csv(SCENARIOS_PATH)
    summaries = []

    for _, row in scenarios.iterrows():
        result = simulate_divergence(
            generations=int(row["generations"]),
            loci=int(row["loci"]),
            N1=int(row["N1"]),
            N2=int(row["N2"]),
            m12=row["m12"],
            m21=row["m21"],
            sel_sd=row["sel_sd"],
            seed=int(row["seed"]),
        )

        final = result[result["generation"] == result["generation"].max()]

        summaries.append(
            {
                "scenario": row["scenario"],
                "mean_delta_p": final["delta_p"].mean(),
                "mean_fst": final["fst"].mean(),
                "max_fst": final["fst"].max(),
            }
        )

    print(pd.DataFrame(summaries).round(4).to_string(index=False))


if __name__ == "__main__":
    main()
