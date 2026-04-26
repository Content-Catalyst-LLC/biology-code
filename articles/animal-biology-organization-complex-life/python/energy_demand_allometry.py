"""
Energy demand and allometric scaling across animal species.

Run:
    python python/energy_demand_allometry.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
TRAITS_PATH = ARTICLE_DIR / "data" / "species_traits.csv"


def main() -> None:
    """Calculate allometric metabolic rate and mass-specific demand."""

    species = pd.read_csv(TRAITS_PATH)
    B0 = 4.2

    species["metabolic_rate"] = B0 * species["body_mass_kg"] ** 0.75
    species["mass_specific_rate"] = species["metabolic_rate"] / species["body_mass_kg"]

    species["energetic_stress_index"] = (
        (
            species["mass_specific_rate"]
            - species["mass_specific_rate"].mean()
        )
        / species["mass_specific_rate"].std(ddof=0)
        + species["exposure_risk"]
    )

    print(species.round(4).to_string(index=False))


if __name__ == "__main__":
    main()
