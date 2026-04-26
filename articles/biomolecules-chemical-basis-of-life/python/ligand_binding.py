"""
Ligand-binding workflow.

Run:
    python python/ligand_binding.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd

from biomolecule_core import ligand_fraction_bound


ARTICLE_DIR = Path(__file__).resolve().parents[1]
BINDING_PATH = ARTICLE_DIR / "data" / "ligand_binding.csv"


def main() -> None:
    """Calculate fractional occupancy for ligand-binding scenarios."""

    binding = pd.read_csv(BINDING_PATH)

    binding["fraction_bound"] = ligand_fraction_bound(
        binding["ligand_uM"].to_numpy(dtype=float),
        binding["Kd_uM"].to_numpy(dtype=float),
    )

    binding["fraction_unbound"] = 1 - binding["fraction_bound"]

    print(binding.round(5).to_string(index=False))


if __name__ == "__main__":
    main()
