"""
Monohybrid and dihybrid inheritance simulations.

Run:
    python python/inheritance_simulation.py
"""

from __future__ import annotations

import random
from collections import Counter

import pandas as pd


random.seed(42)


def gamete_one_locus(genotype: str) -> str:
    """Return one randomly sampled allele from a genotype string."""

    return random.choice(list(genotype))


def simulate_monohybrid(n: int = 10000) -> pd.DataFrame:
    """Simulate Aa x Aa offspring."""

    offspring = []

    for _ in range(n):
        child = "".join(sorted(gamete_one_locus("Aa") + gamete_one_locus("Aa")))
        offspring.append(child)

    counts = Counter(offspring)
    total = sum(counts.values())

    return pd.DataFrame(
        {
            "genotype": sorted(counts.keys()),
            "frequency": [counts[k] / total for k in sorted(counts.keys())],
        }
    )


def simulate_dihybrid(n: int = 10000) -> pd.DataFrame:
    """Simulate AaBb x AaBb with independent assortment."""

    gametes = ["AB", "Ab", "aB", "ab"]
    phenotypes = []

    for _ in range(n):
        g1 = random.choice(gametes)
        g2 = random.choice(gametes)

        A_present = ("A" in g1) or ("A" in g2)
        B_present = ("B" in g1) or ("B" in g2)

        if A_present and B_present:
            phenotypes.append("A_B_")
        elif A_present and not B_present:
            phenotypes.append("A_bb")
        elif not A_present and B_present:
            phenotypes.append("aaB_")
        else:
            phenotypes.append("aabb")

    counts = Counter(phenotypes)
    total = sum(counts.values())

    return pd.DataFrame(
        {
            "phenotype": sorted(counts.keys()),
            "frequency": [counts[k] / total for k in sorted(counts.keys())],
        }
    )


def main() -> None:
    """Run inheritance simulations."""

    print(simulate_monohybrid().round(4).to_string(index=False))
    print(simulate_dihybrid().round(4).to_string(index=False))


if __name__ == "__main__":
    main()
