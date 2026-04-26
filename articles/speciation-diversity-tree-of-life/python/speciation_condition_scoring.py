"""
Speciation condition scoring for lineage-divergence assessment.

Run:
    python python/speciation_condition_scoring.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
SITES_PATH = ARTICLE_DIR / "data" / "speciation_condition_sites.csv"


def condition_class(score: float) -> str:
    """Classify speciation condition score."""

    if score >= 0.70:
        return "strong_lineage_separation"
    if score >= 0.50:
        return "partial_or_emerging_separation"
    return "weak_or_unresolved_separation"


def main() -> None:
    """Score speciation condition examples."""

    sites = pd.read_csv(SITES_PATH)

    sites["speciation_condition_score"] = (
        0.20 * sites["allele_divergence"]
        + 0.20 * sites["reproductive_isolation"]
        + 0.18 * sites["ecological_difference"]
        + 0.16 * sites["phylogenetic_resolution"]
        + 0.14 * (1 - sites["gene_flow_risk"])
        + 0.12 * sites["lineage_distinctiveness"]
    )

    sites["condition_class"] = sites["speciation_condition_score"].apply(condition_class)

    print(
        sites.sort_values("speciation_condition_score", ascending=False)
        .round(3)
        .to_string(index=False)
    )


if __name__ == "__main__":
    main()
