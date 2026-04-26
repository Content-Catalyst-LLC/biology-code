"""
Morphogen-gradient thresholding and fate assignment.

Run:
    python python/morphogen_gradient.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
MORPHOGEN_PATH = ARTICLE_DIR / "data" / "morphogen_gradient.csv"


def assign_fate(value: float) -> str:
    """Assign fate from morphogen concentration."""

    if value > 0.60:
        return "fate_A"
    if value > 0.25:
        return "fate_B"
    return "fate_C"


def main() -> None:
    """Assign fates from morphogen-gradient thresholds."""

    df = pd.read_csv(MORPHOGEN_PATH)
    df["fate"] = df["morphogen"].apply(assign_fate)

    print(df.to_string(index=False))
    print(df["fate"].value_counts().to_string())


if __name__ == "__main__":
    main()
