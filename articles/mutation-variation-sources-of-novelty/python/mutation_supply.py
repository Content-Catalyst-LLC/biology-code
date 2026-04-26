"""
Mutation supply, Poisson expectations, and mutation spectra.

Run:
    python python/mutation_supply.py
"""

from __future__ import annotations

import math
from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
SPECTRUM_PATH = ARTICLE_DIR / "data" / "mutation_spectrum.csv"


def poisson_probability(k: int, lam: float) -> float:
    """Calculate Poisson probability for mutation count k."""

    return (lam**k) * math.exp(-lam) / math.factorial(k)


def main() -> None:
    """Estimate mutation supply and summarize mutation spectrum."""

    mu = 1e-8
    target_length = 1.2e8
    n_genomes = 500

    lam = n_genomes * target_length * mu

    poisson_df = pd.DataFrame(
        {
            "k": list(range(16)),
            "probability": [poisson_probability(k, lam) for k in range(16)],
        }
    )

    spectrum = pd.read_csv(SPECTRUM_PATH)
    spectrum["fraction"] = spectrum["count"] / spectrum["count"].sum()

    print(pd.DataFrame({"expected_mutations_lambda": [lam]}).round(6).to_string(index=False))
    print(poisson_df.round(6).to_string(index=False))
    print(spectrum.sort_values("fraction", ascending=False).round(4).to_string(index=False))


if __name__ == "__main__":
    main()
