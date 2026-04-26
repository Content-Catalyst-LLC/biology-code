"""
Treatment-response summary workflow.

Run:
    python python/treatment_response.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd

from cell_theory_core import fit_exponential_growth, fit_viability_decay


ARTICLE_DIR = Path(__file__).resolve().parents[1]
COUNTS_PATH = ARTICLE_DIR / "data" / "cell_counts.csv"
VIABILITY_PATH = ARTICLE_DIR / "data" / "viability_observations.csv"


def main() -> None:
    """Compare growth and viability parameters by condition."""

    counts = pd.read_csv(COUNTS_PATH)
    viability = pd.read_csv(VIABILITY_PATH)

    growth_rows = []

    for condition, group in counts.groupby("condition"):
        fit = fit_exponential_growth(
            group["time_h"].to_numpy(dtype=float),
            group["cells"].to_numpy(dtype=float),
        )

        growth_rows.append(
            {
                "condition": condition,
                "growth_rate_per_h": fit.growth_rate_per_h,
                "doubling_time_h": fit.doubling_time_h,
            }
        )

    decay_rows = []

    for condition, group in viability.groupby("condition"):
        fit = fit_viability_decay(
            group["time_h"].to_numpy(dtype=float),
            group["viable_cells"].to_numpy(dtype=float),
        )

        decay_rows.append(
            {
                "condition": condition,
                "loss_rate_per_h": fit.loss_rate_per_h,
                "viability_half_life_h": fit.half_life_h,
            }
        )

    growth_df = pd.DataFrame(growth_rows)
    decay_df = pd.DataFrame(decay_rows)

    print(growth_df.round(5).to_string(index=False))
    print(decay_df.round(5).to_string(index=False))


if __name__ == "__main__":
    main()
