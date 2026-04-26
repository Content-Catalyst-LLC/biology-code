"""
Genomic condition scoring.

Run:
    python python/genomic_condition_scoring.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
CONDITION_PATH = ARTICLE_DIR / "data" / "genomic_condition_sites.csv"


def condition_class(score: float) -> str:
    """Classify genomic condition score."""

    if score >= 0.70:
        return "strong_genomic_evidence_system"
    if score >= 0.50:
        return "moderate_genomic_evidence_system"
    return "limited_or_high_uncertainty_system"


def main() -> None:
    """Score genomic condition examples."""

    sites = pd.read_csv(CONDITION_PATH)

    sites["genomic_condition_score"] = (
        0.16 * sites["assembly_quality"]
        + 0.16 * sites["annotation_depth"]
        + 0.16 * sites["variant_quality"]
        + 0.14 * sites["expression_signal"]
        + 0.14 * sites["population_representation"]
        + 0.14 * sites["provenance_quality"]
        + 0.10 * (1 - sites["bias_risk"])
    )

    sites["condition_class"] = sites["genomic_condition_score"].apply(condition_class)

    print(
        sites.sort_values("genomic_condition_score", ascending=False)
        .round(3)
        .to_string(index=False)
    )


if __name__ == "__main__":
    main()
