"""
Developmental condition scoring.

Run:
    python python/developmental_condition_scoring.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
SITES_PATH = ARTICLE_DIR / "data" / "developmental_condition_sites.csv"


def condition_class(score: float) -> str:
    """Classify developmental condition score."""

    if score >= 0.70:
        return "strong_developmental_coherence"
    if score >= 0.50:
        return "moderate_developmental_coherence"
    return "developmentally_constrained_or_at_risk"


def main() -> None:
    """Score developmental condition examples."""

    sites = pd.read_csv(SITES_PATH)

    sites["developmental_condition_score"] = (
        0.18 * sites["growth_coherence"]
        + 0.18 * sites["differentiation_signal"]
        + 0.16 * sites["patterning_signal"]
        + 0.16 * sites["morphogenesis_quality"]
        + 0.16 * sites["environmental_stability"]
        + 0.16 * (1 - sites["perturbation_risk"])
    )

    sites["condition_class"] = sites["developmental_condition_score"].apply(condition_class)

    print(
        sites.sort_values("developmental_condition_score", ascending=False)
        .round(3)
        .to_string(index=False)
    )


if __name__ == "__main__":
    main()
