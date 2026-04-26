"""
Signaling decay and half-life estimation.

Run:
    python python/signaling_decay.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
DECAY_PATH = ARTICLE_DIR / "data" / "signaling_decay.csv"


def main() -> None:
    """Fit a simple exponential signaling decay model."""

    df = pd.read_csv(DECAY_PATH)

    time_min = df["time_min"].to_numpy(dtype=float)
    signal = df["signal"].to_numpy(dtype=float)

    slope, intercept = np.polyfit(time_min, np.log(signal), 1)

    k_est = -slope
    m0_est = np.exp(intercept)
    half_life = np.log(2) / k_est

    df["predicted_signal"] = np.exp(intercept + slope * time_min)
    df["residual"] = df["signal"] - df["predicted_signal"]

    summary = pd.DataFrame(
        {
            "k_est": [k_est],
            "m0_est": [m0_est],
            "half_life_min": [half_life],
        }
    )

    print(summary.round(4).to_string(index=False))
    print(df.round(4).to_string(index=False))


if __name__ == "__main__":
    main()
