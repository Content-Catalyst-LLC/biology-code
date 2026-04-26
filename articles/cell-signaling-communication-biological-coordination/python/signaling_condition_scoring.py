"""
Signaling condition scoring.

Run:
    python python/signaling_condition_scoring.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
CONDITION_PATH = ARTICLE_DIR / "data" / "signaling_condition_sites.csv"


def condition_class(score: float) -> str:
    """Classify signaling condition score."""

    if score >= 0.72:
        return "strong_signaling_coordination"
    if score >= 0.52:
        return "moderate_signaling_coordination"
    return "constrained_or_high_uncertainty_signaling"


def main() -> None:
    """Score signaling condition examples."""

    sites = pd.read_csv(CONDITION_PATH)

    sites["signaling_condition_score"] = (
        0.16 * sites["receptor_detection"]
        + 0.16 * sites["transduction_integrity"]
        + 0.14 * sites["second_messenger_capacity"]
        + 0.15 * sites["feedback_control"]
        + 0.14 * sites["response_specificity"]
        + 0.15 * sites["context_integration"]
        + 0.10 * (1 - sites["noise_risk"])
    )

    sites["condition_class"] = sites["signaling_condition_score"].apply(condition_class)

    print(
        sites.sort_values("signaling_condition_score", ascending=False)
        .round(3)
        .to_string(index=False)
    )


if __name__ == "__main__":
    main()
