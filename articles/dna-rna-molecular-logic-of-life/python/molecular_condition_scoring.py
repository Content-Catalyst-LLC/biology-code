"""
Molecular condition scoring.

Run:
    python python/molecular_condition_scoring.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
CONDITION_PATH = ARTICLE_DIR / "data" / "molecular_condition_sites.csv"


def condition_class(score: float) -> str:
    """Classify molecular condition score."""

    if score >= 0.70:
        return "strong_molecular_continuity_and_response"
    if score >= 0.50:
        return "moderate_molecular_continuity_and_response"
    return "molecularly_constrained_or_high_uncertainty"


def main() -> None:
    """Score molecular condition examples."""

    sites = pd.read_csv(CONDITION_PATH)

    sites["molecular_condition_score"] = (
        0.16 * sites["replication_fidelity"]
        + 0.16 * sites["transcription_signal"]
        + 0.14 * sites["rna_stability"]
        + 0.14 * sites["translation_support"]
        + 0.16 * sites["repair_capacity"]
        + 0.14 * sites["regulatory_context"]
        + 0.10 * (1 - sites["damage_risk"])
    )

    sites["condition_class"] = sites["molecular_condition_score"].apply(condition_class)

    print(
        sites.sort_values("molecular_condition_score", ascending=False)
        .round(3)
        .to_string(index=False)
    )


if __name__ == "__main__":
    main()
