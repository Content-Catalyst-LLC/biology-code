"""
Calculate stoichiometric mass-balance residuals from chosen fluxes.

Run from article directory:
    python python/05_flux_balance_scaffold.py
"""

from pathlib import Path

import pandas as pd

from systems_biology_core import flux_balance_residuals


ARTICLE_DIR = Path(__file__).resolve().parents[1]
REACTIONS_PATH = ARTICLE_DIR / "data" / "flux_reactions.csv"
STOICH_PATH = ARTICLE_DIR / "data" / "stoichiometry.csv"
OUTPUT_PATH = ARTICLE_DIR / "outputs" / "tables" / "flux_balance_residuals.csv"


def main() -> None:
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)

    reactions = pd.read_csv(REACTIONS_PATH)
    stoichiometry = pd.read_csv(STOICH_PATH)

    residuals = flux_balance_residuals(reactions, stoichiometry)
    residuals.to_csv(OUTPUT_PATH, index=False)

    print(reactions.to_string(index=False))
    print(residuals.round(5).to_string(index=False))
    print(f"Saved: {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
