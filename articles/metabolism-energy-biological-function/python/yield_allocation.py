"""
Biomass yield and substrate-allocation workflow.

Run:
    python python/yield_allocation.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd

from metabolism_core import biomass_yield


ARTICLE_DIR = Path(__file__).resolve().parents[1]
SUBSTRATE_PATH = ARTICLE_DIR / "data" / "substrate_biomass.csv"
ENERGY_PATH = ARTICLE_DIR / "data" / "energy_budget.csv"


def main() -> None:
    """Calculate biomass yield and allocation fractions."""

    substrate_df = pd.read_csv(SUBSTRATE_PATH)

    substrate_df["delta_biomass_g_L"] = (
        substrate_df["biomass_final_g_L"] - substrate_df["biomass_initial_g_L"]
    )

    substrate_df["Yxs_g_g"] = [
        biomass_yield(delta_x, delta_s)
        for delta_x, delta_s in zip(
            substrate_df["delta_biomass_g_L"],
            substrate_df["substrate_consumed_g_L"],
        )
    ]

    substrate_df["product_fraction"] = substrate_df["product_g_L"] / substrate_df["substrate_consumed_g_L"]
    substrate_df["maintenance_fraction"] = (
        substrate_df["maintenance_estimate_g_L"] / substrate_df["substrate_consumed_g_L"]
    )

    allocation_df = pd.read_csv(ENERGY_PATH)
    allocation_columns = [
        "substrate_to_growth",
        "substrate_to_maintenance",
        "substrate_to_product",
        "substrate_loss",
    ]

    for col in allocation_columns:
        allocation_df[col + "_fraction"] = allocation_df[col] / allocation_df["substrate_input"]

    allocation_df["mass_balance_residual"] = allocation_df["substrate_input"] - allocation_df[allocation_columns].sum(axis=1)

    print(substrate_df.round(4).to_string(index=False))
    print(allocation_df.round(4).to_string(index=False))


if __name__ == "__main__":
    main()
