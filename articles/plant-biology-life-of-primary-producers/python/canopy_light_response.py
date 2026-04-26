"""
Canopy light-response screening.

Run:
    python python/canopy_light_response.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
SCENARIOS_PATH = ARTICLE_DIR / "data" / "light_response_scenarios.csv"


def light_response(I: float, alpha: float = 0.05, Amax: float = 18, Rd: float = 1.5) -> float:
    """Return net assimilation from a simple light-response curve."""

    return (alpha * I * Amax) / (alpha * I + Amax) - Rd


def main() -> None:
    """Compare canopy response under physiological scenarios."""

    scenarios = pd.read_csv(SCENARIOS_PATH)
    irradiance = np.arange(0, 2001, 100)
    rows = []

    for _, row in scenarios.iterrows():
        for I in irradiance:
            rows.append(
                {
                    "scenario": row["scenario"],
                    "irradiance": I,
                    "assimilation": light_response(
                        I,
                        alpha=row["alpha"],
                        Amax=row["Amax"],
                        Rd=row["Rd"],
                    ),
                }
            )

    output = pd.DataFrame(rows)

    summary = (
        output.groupby("scenario")
        .agg(
            max_assimilation=("assimilation", "max"),
            mean_assimilation=("assimilation", "mean"),
        )
        .reset_index()
    )

    print(summary.round(3).to_string(index=False))


if __name__ == "__main__":
    main()
