"""
Epigenetic condition scoring.

Run:
    python python/epigenetic_condition_scoring.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
SITES_PATH = ARTICLE_DIR / "data" / "epigenetic_condition_sites.csv"


def condition_class(score: float) -> str:
    """Classify regulatory condition score."""

    if score >= 0.70:
        return "strong_regulatory_signal"
    if score >= 0.50:
        return "moderate_regulatory_signal"
    return "weak_or_high_uncertainty_signal"


def main() -> None:
    """Score epigenetic condition examples."""

    sites = pd.read_csv(SITES_PATH)

    sites["epigenetic_condition_score"] = (
        0.18 * sites["expression_stability"]
        + 0.18 * sites["accessibility_signal"]
        + 0.16 * sites["methylation_quality"]
        + 0.16 * sites["state_memory"]
        + 0.16 * sites["environmental_responsiveness"]
        + 0.16 * (1 - sites["batch_risk"])
    )

    sites["condition_class"] = sites["epigenetic_condition_score"].apply(condition_class)

    print(
        sites.sort_values("epigenetic_condition_score", ascending=False)
        .round(3)
        .to_string(index=False)
    )


if __name__ == "__main__":
    main()
