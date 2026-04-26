"""
Membrane transport workflow.

Run:
    python python/membrane_transport.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd

from cell_architecture_core import permeability_flux


ARTICLE_DIR = Path(__file__).resolve().parents[1]
TRANSPORT_PATH = ARTICLE_DIR / "data" / "membrane_transport_observations.csv"


def main() -> None:
    """Calculate permeability-limited flux across scenarios."""

    df = pd.read_csv(TRANSPORT_PATH)

    df["flux_concentration_units_um_s"] = [
        permeability_flux(p, cout, cin)
        for p, cout, cin in zip(
            df["permeability_um_s"],
            df["external_concentration"],
            df["internal_concentration"],
        )
    ]

    df["area_scaled_flux"] = df["flux_concentration_units_um_s"] * df["membrane_area_um2"]

    print(df.round(5).to_string(index=False))


if __name__ == "__main__":
    main()
