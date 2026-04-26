"""
Energy budget allocation workflow.

Run:
    python python/energy_budget_allocation.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
ENERGY_PATH = ARTICLE_DIR / "data" / "energy_budget.csv"


def main() -> None:
    """Summarize energy allocation fractions and residuals."""

    df = pd.read_csv(ENERGY_PATH)

    allocation_columns = ["energy_growth", "energy_maintenance", "energy_repair", "energy_loss"]

    for col in allocation_columns:
        df[col + "_fraction"] = df[col] / df["energy_input"]

    df["energy_balance_residual"] = df["energy_input"] - df[allocation_columns].sum(axis=1)
    df["maintenance_repair_fraction"] = (df["energy_maintenance"] + df["energy_repair"]) / df["energy_input"]

    print(df.round(5).to_string(index=False))


if __name__ == "__main__":
    main()
