"""
Viability-decay fitting workflow.

Run:
    python python/viability_decay.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd

from definition_core import fit_viability_decay


ARTICLE_DIR = Path(__file__).resolve().parents[1]
VIABILITY_PATH = ARTICLE_DIR / "data" / "viability_observations.csv"


def main() -> None:
    """Fit viability-decay model by condition."""

    data = pd.read_csv(VIABILITY_PATH)

    rows = []

    for condition, group in data.groupby("condition"):
        fit = fit_viability_decay(
            group["time_h"].to_numpy(dtype=float),
            group["live_cells"].to_numpy(dtype=float),
        )

        rows.append(
            {
                "condition": condition,
                "loss_rate_per_h": fit.loss_rate,
                "initial_viable_count": fit.initial_viable_count,
                "half_life_h": fit.half_life,
                "r_squared_log_space": fit.r_squared_log_space,
            }
        )

    print(pd.DataFrame(rows).round(5).to_string(index=False))


if __name__ == "__main__":
    main()
