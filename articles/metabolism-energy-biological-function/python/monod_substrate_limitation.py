"""
Monod-style substrate-limited growth workflow.

Run:
    python python/monod_substrate_limitation.py
"""

from __future__ import annotations

import numpy as np
import pandas as pd

from metabolism_core import monod_growth_rate


def main() -> None:
    """Generate Monod growth-rate response table."""

    substrate = np.linspace(0, 20, 200)
    mu_max = 0.08
    ks = 2.5

    mu = monod_growth_rate(substrate, mu_max=mu_max, ks=ks)

    df = pd.DataFrame(
        {
            "substrate_mM": substrate,
            "growth_rate_per_h": mu,
            "fraction_mu_max": mu / mu_max,
        }
    )

    half_sat_row = df.iloc[(df["growth_rate_per_h"] - mu_max / 2).abs().argmin()]

    print(df.head(12).round(5).to_string(index=False))
    print(df.tail(12).round(5).to_string(index=False))
    print("Approximate half-saturation row:")
    print(half_sat_row.round(5).to_string())


if __name__ == "__main__":
    main()
