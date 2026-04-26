"""
Taxonomic-confidence scoring workflow.

Run:
    python python/taxonomic_confidence.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd

from taxonomy_core import taxonomic_confidence_score


ARTICLE_DIR = Path(__file__).resolve().parents[1]
ASSIGN_PATH = ARTICLE_DIR / "data" / "taxonomic_assignments.csv"


def confidence_class(score: float) -> str:
    if score >= 0.75:
        return "high_confidence"
    if score >= 0.55:
        return "moderate_confidence"
    return "low_confidence"


def main() -> None:
    assignments = pd.read_csv(ASSIGN_PATH)

    assignments["taxonomic_confidence_score"] = [
        taxonomic_confidence_score(s, m, g, p, u)
        for s, m, g, p, u in zip(
            assignments["sequence_similarity"],
            assignments["morphological_support"],
            assignments["geographic_plausibility"],
            assignments["phylogenetic_support"],
            assignments["uncertainty_penalty"],
        )
    ]

    assignments["confidence_class"] = assignments["taxonomic_confidence_score"].apply(confidence_class)

    print(
        assignments.sort_values("taxonomic_confidence_score", ascending=False)
        .round(3)
        .to_string(index=False)
    )


if __name__ == "__main__":
    main()
