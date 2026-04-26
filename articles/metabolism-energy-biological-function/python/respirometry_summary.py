"""
Respirometry summary workflow.

Run:
    python python/respirometry_summary.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
RESP_PATH = ARTICLE_DIR / "data" / "respirometry.csv"


def estimate_slope(time_min: np.ndarray, oxygen_mg_L: np.ndarray) -> float:
    """Estimate oxygen slope in mg/L/min using linear regression."""

    slope, _intercept = np.polyfit(time_min, oxygen_mg_L, 1)
    return float(slope)


def main() -> None:
    """Estimate oxygen-consumption slopes by sample."""

    df = pd.read_csv(RESP_PATH)

    rows = []

    for sample, group in df.groupby("sample"):
        slope = estimate_slope(
            group["time_min"].to_numpy(dtype=float),
            group["oxygen_mg_L"].to_numpy(dtype=float),
        )

        rows.append(
            {
                "sample": sample,
                "oxygen_slope_mg_L_min": slope,
                "oxygen_consumption_mg_L_min": -slope,
                "temperature_C": group["temperature_C"].mean(),
            }
        )

    summary = pd.DataFrame(rows)

    print(summary.round(5).to_string(index=False))


if __name__ == "__main__":
    main()
