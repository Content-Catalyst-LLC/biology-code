"""
Genotype-specific selection and allele-frequency updates.

Run:
    python python/genotype_selection.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
SCENARIOS_PATH = ARTICLE_DIR / "data" / "selection_scenarios.csv"


def run_selection(
    generations: int,
    p0: float,
    w_AA: float,
    w_Aa: float,
    w_aa: float,
) -> pd.DataFrame:
    """Simulate deterministic allele-frequency change under genotype selection."""

    records = []
    p = p0

    for generation in range(generations + 1):
        q = 1 - p
        expected_heterozygosity = 2 * p * q

        records.append(
            {
                "generation": generation,
                "p": p,
                "q": q,
                "expected_heterozygosity": expected_heterozygosity,
            }
        )

        if generation == generations:
            break

        mean_fitness = p**2 * w_AA + 2 * p * q * w_Aa + q**2 * w_aa
        p = (p**2 * w_AA + p * q * w_Aa) / mean_fitness

    return pd.DataFrame(records)


def main() -> None:
    """Run genotype-selection scenarios."""

    scenarios = pd.read_csv(SCENARIOS_PATH)
    summaries = []

    for _, row in scenarios.iterrows():
        result = run_selection(
            generations=int(row["generations"]),
            p0=row["p0"],
            w_AA=row["w_AA"],
            w_Aa=row["w_Aa"],
            w_aa=row["w_aa"],
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
