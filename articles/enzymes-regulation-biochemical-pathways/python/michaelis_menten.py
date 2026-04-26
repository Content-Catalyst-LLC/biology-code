"""
Michaelis-Menten kinetics.

Run:
    python python/michaelis_menten.py
"""

from __future__ import annotations

import numpy as np
import pandas as pd


def michaelis_menten(substrate: np.ndarray, vmax: float, km: float) -> np.ndarray:
    """Calculate Michaelis-Menten velocity."""

    return (vmax * substrate) / (km + substrate)


def main() -> None:
    """Generate a Michaelis-Menten response table."""

    substrate = np.linspace(0.1, 30, 300)
    vmax = 120.0
    km = 5.0

    velocity = michaelis_menten(substrate, vmax, km)

    df = pd.DataFrame(
        {
            "substrate_mM": substrate,
            "velocity_units_min": velocity,
            "fraction_vmax": velocity / vmax,
        }
    )

    half_row = df.iloc[(df["velocity_units_min"] - vmax / 2).abs().argmin()]

    print(df.head(12).round(4).to_string(index=False))
    print(df.tail(12).round(4).to_string(index=False))
    print("Approximate half-maximal row:")
    print(half_row.round(4).to_string())


if __name__ == "__main__":
    main()
