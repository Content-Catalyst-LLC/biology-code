"""
Growth and energy-throughput workflow.

Run:
    python python/growth_energy_model.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd

from water_energy_core import fit_exponential_growth


ARTICLE_DIR = Path(__file__).resolve().parents[1]
GROWTH_PATH = ARTICLE_DIR / "data" / "growth_observations.csv"


def main() -> None:
    """Fit exponential growth by condition."""

    df = pd.read_csv(GROWTH_PATH)

    rows = []

    for condition, group in df.groupby("condition"):
        fit = fit_exponential_growth(
            group["time_h"].to_numpy(dtype=float),
            group["abundance"].to_numpy(dtype=float),
        )

        rows.append(
            {
                "condition": condition,
                "growth_rate_per_h": fit.growth_rate_per_h,
                "initial_abundance": fit.initial_abundance,
                "doubling_time_h": fit.doubling_time_h,
                "r_squared_log_space": fit.r_squared_log_space,
            }
        )

    print(pd.DataFrame(rows).round(5).to_string(index=False))


if __name__ == "__main__":
    main()
