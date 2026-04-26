"""
Allele-frequency time-series screening.

Run:
    python python/time_series_frequency_screening.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
TIME_SERIES_PATH = ARTICLE_DIR / "data" / "allele_frequency_timeseries.csv"


def main() -> None:
    """Calculate finite differences and logit-transformed allele frequencies."""

    df = pd.read_csv(TIME_SERIES_PATH)

    df["delta_p"] = df["allele_frequency"].diff()
    df["delta_p_per_time"] = df["delta_p"] / df["time"].diff()

    eps = 1e-9
    df["logit_p"] = np.log(
        (df["allele_frequency"] + eps)
        / (1 - df["allele_frequency"] + eps)
    )

    print(df.round(4).to_string(index=False))


if __name__ == "__main__":
    main()
