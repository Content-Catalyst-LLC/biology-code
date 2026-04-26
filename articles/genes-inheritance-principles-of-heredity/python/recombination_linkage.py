"""
Linked loci and recombination analysis.

Run:
    python python/recombination_linkage.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
RECOMB_PATH = ARTICLE_DIR / "data" / "recombination_observations.csv"


def simulate_recombination(r: float = 0.18, n: int = 20000, seed: int = 42) -> pd.DataFrame:
    """Simulate gametes from a coupling-phase heterozygote AB/ab."""

    rng = np.random.default_rng(seed)

    gametes = np.array(["AB", "ab", "Ab", "aB"])
    probabilities = np.array([(1 - r) / 2, (1 - r) / 2, r / 2, r / 2])

    sampled = rng.choice(gametes, size=n, replace=True, p=probabilities)

    return (
        pd.Series(sampled)
        .value_counts(normalize=True)
        .rename_axis("gamete")
        .reset_index(name="frequency")
        .sort_values("gamete")
    )


def main() -> None:
    """Estimate recombination from observations and run simulation."""

    observed = pd.read_csv(RECOMB_PATH)
    total = observed["count"].sum()

    observed_summary = (
        observed.groupby("class")["count"]
        .sum()
        .reset_index()
        .assign(frequency=lambda x: x["count"] / total)
    )

    estimated_r = observed.loc[observed["class"] == "recombinant", "count"].sum() / total

    print(observed_summary.round(4).to_string(index=False))
    print("Observed recombination fraction:", round(estimated_r, 4))
    print(simulate_recombination().round(4).to_string(index=False))


if __name__ == "__main__":
    main()
