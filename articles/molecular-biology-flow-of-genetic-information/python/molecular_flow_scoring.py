"""
Molecular information-flow condition scoring.

Run:
    python python/molecular_flow_scoring.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
CONDITION_PATH = ARTICLE_DIR / "data" / "molecular_flow_condition_sites.csv"


def condition_class(score: float) -> str:
    """Classify molecular information-flow condition score."""

    if score >= 0.72:
        return "strong_molecular_information_flow"
    if score >= 0.52:
        return "moderate_molecular_information_flow"
    return "constrained_or_high_uncertainty_information_flow"


def main() -> None:
    """Score molecular information-flow condition examples."""

    sites = pd.read_csv(CONDITION_PATH)

    sites["molecular_flow_score"] = (
        0.16 * sites["replication_fidelity"]
        + 0.15 * sites["transcription_signal"]
        + 0.14 * sites["rna_processing"]
        + 0.14 * sites["translation_support"]
        + 0.16 * sites["repair_capacity"]
        + 0.15 * sites["regulatory_context"]
        + 0.10 * (1 - sites["expression_noise_risk"])
    )

    sites["condition_class"] = sites["molecular_flow_score"].apply(condition_class)

    print(
        sites.sort_values("molecular_flow_score", ascending=False)
        .round(3)
        .to_string(index=False)
    )


if __name__ == "__main__":
    main()
