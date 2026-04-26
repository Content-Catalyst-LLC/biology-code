"""
Genotype expectations and expected heterozygosity.

Run:
    python python/genotype_expectations.py
"""

from __future__ import annotations

import pandas as pd


def main() -> None:
    """Calculate Hardy-Weinberg genotype expectations."""

    p = 0.7
    q = 1 - p

    genotype_df = pd.DataFrame(
        {
            "genotype": ["AA", "Aa", "aa"],
            "expected_frequency": [p**2, 2 * p * q, q**2],
        }
    )

    expected_heterozygosity = 2 * p * q

    print(genotype_df.round(4).to_string(index=False))
    print("Expected heterozygosity:", round(expected_heterozygosity, 4))


if __name__ == "__main__":
    main()
