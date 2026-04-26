"""
Growth-model workflows for metabolism.

Run:
    python python/growth_models.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd

from metabolism_core import fit_exponential_growth, logistic_growth


ARTICLE_DIR = Path(__file__).resolve().parents[1]
GROWTH_PATH = ARTICLE_DIR / "data" / "growth_observations.csv"


def main() -> None:
    """Fit exponential growth by condition and simulate logistic growth."""

    df = pd.read_csv(GROWTH_PATH)

    fit_rows = []

    for condition, group in df.groupby("condition"):
        fit = fit_exponential_growth(
            group["time_h"].to_numpy(dtype=float),
            group["abundance"].to_numpy(dtype=float),
        )

        fit_rows.append(
            {
                "condition": condition,
                "growth_rate_per_h": fit.growth_rate_per_h,
                "initial_abundance": fit.initial_abundance,
                "doubling_time_h": fit.doubling_time_h,
                "r_squared_log_space": fit.r_squared_log_space,
            }
        )

    fit_df = pd.DataFrame(fit_rows)

    time_h = np.linspace(0, 96, 25)
    logistic_df = pd.DataFrame({"time_h": time_h})
    logistic_df["control"] = logistic_growth(time_h, 1.0e5, 0.035, 1.0e6)
    logistic_df["stressed"] = logistic_growth(time_h, 1.0e5, 0.020, 1.0e6)

    print(fit_df.round(5).to_string(index=False))
    print(logistic_df.round(2).to_string(index=False))


if __name__ == "__main__":
    main()
