"""
Trait-dependent extinction-risk screening.

Run:
    python python/trait_risk_screening.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
TRAIT_PATH = ARTICLE_DIR / "data" / "trait_risk_taxa.csv"


def risk_class(score: float) -> str:
    """Classify risk from a simple index."""

    if score >= 0.70:
        return "high"
    if score >= 0.45:
        return "moderate"
    return "lower"


def main() -> None:
    """Calculate trait-dependent extinction-risk index."""

    taxa = pd.read_csv(TRAIT_PATH)

    taxa["risk_index"] = (
        0.4 * (1 - taxa["range_size"])
        + 0.3 * (1 - taxa["trophic_flexibility"])
        + 0.3 * taxa["habitat_dependence"]
    )

    taxa["risk_class"] = taxa["risk_index"].apply(risk_class)

    print(
        taxa.sort_values("risk_index", ascending=False)
        .round(3)
        .to_string(index=False)
    )


if __name__ == "__main__":
    main()
