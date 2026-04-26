"""
Signaling strategy and receiver-response screening.

This script models communication as a sender-receiver problem with sender
utility, receiver detectability, receiver state, and environmental noise.

Run:
    python python/signaling_strategy_screening.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
SIGNALS_PATH = ARTICLE_DIR / "data" / "signaling_strategies.csv"


def logistic_response(detectability: pd.Series, receiver_state: float) -> pd.Series:
    """Calculate receiver response probability using a logistic function."""

    return 1 / (1 + np.exp(-6 * (detectability * receiver_state - 0.35)))


def main() -> None:
    """Run baseline and noisy-environment signaling scenarios."""

    signals = pd.read_csv(SIGNALS_PATH)

    signals["sender_utility"] = (
        signals["mate_benefit"]
        - 0.8 * signals["energetic_cost"]
        - 1.1 * signals["predator_exposure"]
    )

    receiver_state = 0.75

    signals["receiver_response"] = logistic_response(
        signals["receiver_detectability"],
        receiver_state=receiver_state,
    )

    signals["combined_score"] = (
        signals["sender_utility"] * signals["receiver_response"]
    )

    signals["receiver_detectability_noisy"] = (
        signals["receiver_detectability"] - 0.20
    ).clip(lower=0)

    signals["receiver_response_noisy"] = logistic_response(
        signals["receiver_detectability_noisy"],
        receiver_state=receiver_state,
    )

    signals["combined_score_noisy"] = (
        signals["sender_utility"] * signals["receiver_response_noisy"]
    )

    signals["delta_noisy"] = (
        signals["combined_score_noisy"] - signals["combined_score"]
    )

    print(signals.round(3).to_string(index=False))


if __name__ == "__main__":
    main()
