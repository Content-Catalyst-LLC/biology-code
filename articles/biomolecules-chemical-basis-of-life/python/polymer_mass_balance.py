"""
Polymerization mass-balance workflow.

Run:
    python python/polymer_mass_balance.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd

from biomolecule_core import polymer_mass_estimate


ARTICLE_DIR = Path(__file__).resolve().parents[1]
POLYMER_PATH = ARTICLE_DIR / "data" / "polymerization_examples.csv"


def main() -> None:
    """Estimate polymer mass under a simple condensation mass-balance scaffold."""

    polymers = pd.read_csv(POLYMER_PATH)

    polymers["n_bonds"] = polymers["monomer_count"] - 1
    polymers["estimated_water_loss_Da"] = (
        polymers["n_bonds"] * polymers["water_loss_per_bond_Da"]
    )

    polymers["estimated_polymer_mass_Da"] = [
        polymer_mass_estimate(n, m, w)
        for n, m, w in zip(
            polymers["monomer_count"],
            polymers["mean_monomer_mass_Da"],
            polymers["water_loss_per_bond_Da"],
        )
    ]

    print(polymers.round(5).to_string(index=False))


if __name__ == "__main__":
    main()
