"""
Experimental signal-quality scoring workflow.

Run:
    python python/experimental_signal_scoring.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd

from biological_methods_core import signal_quality_score


ARTICLE_DIR = Path(__file__).resolve().parents[1]
SIGNAL_PATH = ARTICLE_DIR / "data" / "experimental_signal_scores.csv"


def signal_class(score: float) -> str:
    if score >= 0.72:
        return "strong_signal"
    if score >= 0.50:
        return "moderate_signal"
    return "weak_or_uncertain_signal"


def main() -> None:
    signals = pd.read_csv(SIGNAL_PATH)

    signals["signal_quality_score"] = [
        signal_quality_score(s, r, c, n)
        for s, r, c, n in zip(
            signals["signal_strength"],
            signals["reproducibility"],
            signals["control_separation"],
            signals["noise_penalty"],
        )
    ]

    signals["signal_class"] = signals["signal_quality_score"].apply(signal_class)

    print(
        signals.sort_values("signal_quality_score", ascending=False)
        .round(3)
        .to_string(index=False)
    )


if __name__ == "__main__":
    main()
