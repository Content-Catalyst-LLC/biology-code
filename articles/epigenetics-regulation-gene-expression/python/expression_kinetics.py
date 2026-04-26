"""
Expression kinetics: transcript decay, half-life, and area under the curve.

Run:
    python python/expression_kinetics.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
EXPR_PATH = ARTICLE_DIR / "data" / "expression_timecourse.csv"


def main() -> None:
    """Fit exponential transcript decay and calculate integrated exposure."""

    df = pd.read_csv(EXPR_PATH)
    time_h = df["time_h"].to_numpy(dtype=float)
    expr = df["expression"].to_numpy(dtype=float)

    slope, intercept = np.polyfit(time_h, np.log(expr), 1)

    k_est = -slope
    m0_est = np.exp(intercept)
    half_life_h = np.log(2) / k_est
    auc = np.trapz(expr, time_h)

    summary = pd.DataFrame(
        {
            "k_est": [k_est],
            "m0_est": [m0_est],
            "half_life_h": [half_life_h],
            "AUC": [auc],
        }
    )

    print(summary.round(4).to_string(index=False))


if __name__ == "__main__":
    main()
