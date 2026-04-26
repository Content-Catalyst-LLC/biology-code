"""
Biomolecular composition analysis.

Run:
    python python/composition_analysis.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
COMPOSITION_PATH = ARTICLE_DIR / "data" / "biomolecule_composition.csv"
ELEMENTAL_PATH = ARTICLE_DIR / "data" / "elemental_composition.csv"


def main() -> None:
    """Summarize biomolecular composition and elemental ratios."""

    composition = pd.read_csv(COMPOSITION_PATH)

    biomolecule_columns = [
        "carbohydrate_mg",
        "lipid_mg",
        "protein_mg",
        "nucleic_acid_mg",
        "metabolite_mg",
    ]

    composition["total_biomolecule_mg"] = composition[biomolecule_columns].sum(axis=1)

    for col in biomolecule_columns:
        composition[col.replace("_mg", "_fraction")] = (
            composition[col] / composition["total_biomolecule_mg"]
        )

    elements = pd.read_csv(ELEMENTAL_PATH)
    elements["C_to_N"] = elements["carbon_mmol"] / elements["nitrogen_mmol"]
    elements["C_to_P"] = elements["carbon_mmol"] / elements["phosphorus_mmol"]
    elements["N_to_P"] = elements["nitrogen_mmol"] / elements["phosphorus_mmol"]

    print(composition.round(4).to_string(index=False))
    print(elements.round(4).to_string(index=False))


if __name__ == "__main__":
    main()
