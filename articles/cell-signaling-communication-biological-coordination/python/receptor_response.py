"""
Receptor occupancy and Hill response.

Run:
    python python/receptor_response.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
RESPONSE_PATH = ARTICLE_DIR / "data" / "receptor_response.csv"


def main() -> None:
    """Calculate receptor occupancy and cooperative response."""

    observed = pd.read_csv(RESPONSE_PATH)

    L = observed["ligand"].to_numpy(dtype=float)

    Kd = 1.5
    K = 2.0
    n = 3.0

    observed["occupancy"] = L / (Kd + L)
    observed["hill_response"] = L**n / (K**n + L**n)
    observed["residual_observed_minus_hill"] = observed["observed_response"] - observed["hill_response"]

    threshold_row = observed.iloc[(observed["hill_response"] - 0.5).abs().argmin()]

    print(observed.round(4).to_string(index=False))
    print("\nApproximate half-response row:")
    print(threshold_row.round(4).to_string())


if __name__ == "__main__":
    main()
