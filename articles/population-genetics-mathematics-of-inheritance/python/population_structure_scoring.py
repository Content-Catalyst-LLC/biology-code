"""
Population-structure and condition scoring.

Run:
    python python/population_structure_scoring.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
FREQ_PATH = ARTICLE_DIR / "data" / "multipop_allele_frequencies.csv"
SITES_PATH = ARTICLE_DIR / "data" / "population_condition_sites.csv"


def fst_style(row: pd.Series, pop_columns: list[str]) -> float:
    """Calculate FST-style structure from population allele frequencies."""

    p_values = row[pop_columns].astype(float)
    pbar = p_values.mean()
    hs = (2 * p_values * (1 - p_values)).mean()
    ht = 2 * pbar * (1 - pbar)

    if ht <= 0:
        return 0.0

    return (ht - hs) / ht


def condition_class(score: float) -> str:
    """Classify population-genetic condition."""

    if score >= 0.70:
        return "strong"
    if score >= 0.50:
        return "moderate"
    return "at_risk"


def main() -> None:
    """Summarize population structure and condition scores."""

    freqs = pd.read_csv(FREQ_PATH)
    pop_columns = [col for col in freqs.columns if col.startswith("pop")]
    freqs["fst_style"] = freqs.apply(lambda row: fst_style(row, pop_columns), axis=1)

    print("Locus-level FST-style structure:")
    print(freqs[["locus", "fst_style"]].round(4).to_string(index=False))
    print(f"Genome-wide mean FST-style value: {freqs['fst_style'].mean():.4f}")

    sites = pd.read_csv(SITES_PATH)
    sites["population_condition_score"] = (
        0.18 * sites["heterozygosity"]
        + 0.18 * sites["allelic_richness"]
        + 0.16 * sites["gene_flow"]
        + 0.16 * (1 - sites["fragmentation_pressure"])
        + 0.16 * (1 - sites["bottleneck_risk"])
        + 0.16 * sites["adaptive_capacity"]
    )
    sites["condition_class"] = sites["population_condition_score"].apply(condition_class)

    print("\nPopulation condition scores:")
    print(
        sites.sort_values("population_condition_score", ascending=False)
        .round(3)
        .to_string(index=False)
    )


if __name__ == "__main__":
    main()
