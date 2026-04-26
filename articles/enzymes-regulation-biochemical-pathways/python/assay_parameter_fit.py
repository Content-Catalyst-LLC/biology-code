"""
Michaelis-Menten parameter fitting by transparent grid search.

Run:
    python python/assay_parameter_fit.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
ASSAY_PATH = ARTICLE_DIR / "data" / "enzyme_assay.csv"


def main() -> None:
    """Fit Vmax and Km from assay data using grid search."""

    assay = pd.read_csv(ASSAY_PATH)
    substrate = assay["substrate_mM"].to_numpy(dtype=float)
    observed = assay["velocity_units_min"].to_numpy(dtype=float)

    vmax_grid = np.linspace(80, 150, 141)
    km_grid = np.linspace(1, 12, 111)

    rows = []

    for vmax in vmax_grid:
        for km in km_grid:
            pred = (vmax * substrate) / (km + substrate)
            sse = np.sum((observed - pred) ** 2)
            rows.append({"Vmax": vmax, "Km": km, "SSE": sse})

    fit_df = pd.DataFrame(rows)
    best = fit_df.sort_values("SSE").head(1)

    best_vmax = float(best["Vmax"].iloc[0])
    best_km = float(best["Km"].iloc[0])

    assay["predicted_velocity"] = (best_vmax * substrate) / (best_km + substrate)
    assay["residual"] = assay["velocity_units_min"] - assay["predicted_velocity"]

    print(best.round(4).to_string(index=False))
    print(assay.round(4).to_string(index=False))


if __name__ == "__main__":
    main()
