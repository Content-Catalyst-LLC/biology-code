"""
Transparent toy flux-balance workflow.

Run:
    python python/toy_flux_balance.py
"""

from __future__ import annotations

import itertools
from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
FLUX_PATH = ARTICLE_DIR / "data" / "flux_reactions.csv"


def main() -> None:
    """Search feasible fluxes for a small mass-balance-constrained toy system."""

    reaction_table = pd.read_csv(FLUX_PATH)

    glucose_uptake = 10.0
    tolerance = 0.05

    candidate_fluxes = []

    for biomass_flux, product_flux, respiration_flux in itertools.product(
        np.linspace(0, 10, 101),
        np.linspace(0, 10, 101),
        np.linspace(0, 10, 101),
    ):
        precursor_balance = glucose_uptake - biomass_flux - product_flux - respiration_flux

        if abs(precursor_balance) <= tolerance:
            objective = biomass_flux + 0.25 * product_flux

            candidate_fluxes.append(
                {
                    "glucose_uptake": glucose_uptake,
                    "biomass_flux": biomass_flux,
                    "product_flux": product_flux,
                    "respiration_flux": respiration_flux,
                    "precursor_balance": precursor_balance,
                    "objective": objective,
                }
            )

    flux_df = pd.DataFrame(candidate_fluxes)
    best = flux_df.sort_values("objective", ascending=False).head(10)

    print(reaction_table.to_string(index=False))
    print(best.round(4).to_string(index=False))


if __name__ == "__main__":
    main()
