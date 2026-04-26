"""
Developmental growth: exponential fit, doubling time, and stage-dependent logistic growth.

Run:
    python python/developmental_growth.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
GROWTH_PATH = ARTICLE_DIR / "data" / "developmental_growth.csv"


def stage_dependent_growth(
    t_end: float = 40,
    dt: float = 0.1,
    N0: float = 1e4,
    K: float = 8e4,
    r_early: float = 0.08,
    r_late: float = 0.03,
    switch_time: float = 18,
) -> pd.DataFrame:
    """Simulate logistic growth with a developmental stage shift."""

    times = np.arange(0, t_end + dt, dt)
    cells = np.zeros_like(times)
    cells[0] = N0

    for i in range(1, len(times)):
        r = r_early if times[i - 1] < switch_time else r_late
        dN = r * cells[i - 1] * (1 - cells[i - 1] / K)
        cells[i] = cells[i - 1] + dN * dt

    return pd.DataFrame({"time": times, "cells": cells})


def main() -> None:
    """Estimate early growth and run stage-dependent simulation."""

    growth = pd.read_csv(GROWTH_PATH)
    early = growth.iloc[:5].copy()

    slope, intercept = np.polyfit(early["time_h"], np.log(early["cells"]), 1)

    r_est = slope
    N0_est = np.exp(intercept)
    doubling_time_h = np.log(2) / r_est

    summary = pd.DataFrame(
        {
            "r_est": [r_est],
            "N0_est": [N0_est],
            "doubling_time_h": [doubling_time_h],
        }
    )

    sim = stage_dependent_growth()

    print(summary.round(4).to_string(index=False))
    print(sim.head(12).round(2).to_string(index=False))
    print(sim.tail(12).round(2).to_string(index=False))


if __name__ == "__main__":
    main()
