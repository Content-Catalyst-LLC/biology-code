"""
Membrane flux workflow.

Run:
    python python/membrane_flux.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd

from cell_theory_core import membrane_flux


ARTICLE_DIR = Path(__file__).resolve().parents[1]
FLUX_PATH = ARTICLE_DIR / "data" / "membrane_gradients.csv"


def main() -> None:
    """Calculate membrane flux across gradient scenarios."""

    gradients = pd.read_csv(FLUX_PATH)

    gradients["concentration_gradient"] = (
        gradients["concentration_outside"] - gradients["concentration_inside"]
    ) / gradients["distance_cm"]

    gradients["flux_units"] = [
        membrane_flux(d, cin, cout, dx)
        for d, cin, cout, dx in zip(
            gradients["diffusion_coefficient_cm2_s"],
            gradients["concentration_inside"],
            gradients["concentration_outside"],
            gradients["distance_cm"],
        )
    ]

    print(gradients.round(8).to_string(index=False))


if __name__ == "__main__":
    main()
