"""
Migration-selection balance across two populations.

Run:
    python python/migration_selection_balance.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
SCENARIOS_PATH = ARTICLE_DIR / "data" / "migration_selection_scenarios.csv"


def migration_selection_balance(
    generations: int,
    p1_0: float,
    p2_0: float,
    m12: float,
    m21: float,
    s1: float,
    s2: float,
) -> pd.DataFrame:
    """Simulate a simple migration-selection balance scenario."""

    records = []
    p1 = p1_0
    p2 = p2_0

    for generation in range(generations + 1):
        records.append(
            {
                "generation": generation,
                "p1": p1,
                "p2": p2,
                "delta_p": abs(p1 - p2),
            }
        )

        if generation == generations:
            continue

        p1_selected = (p1 * (1 + s1)) / (p1 * (1 + s1) + (1 - p1))
        p2_selected = (p2 * (1 + s2)) / (p2 * (1 + s2) + (1 - p2))

        p1_next = (1 - m12) * p1_selected + m12 * p2_selected
        p2_next = (1 - m21) * p2_selected + m21 * p1_selected

        p1, p2 = p1_next, p2_next

    return pd.DataFrame(records)


def main() -> None:
    """Run migration-selection scenarios."""

    scenarios = pd.read_csv(SCENARIOS_PATH)
    summaries = []

    for _, row in scenarios.iterrows():
        result = migration_selection_balance(
            generations=int(row["generations"]),
            p1_0=row["p1_0"],
            p2_0=row["p2_0"],
            m12=row["m12"],
            m21=row["m21"],
            s1=row["s1"],
            s2=row["s2"],
        )

        final = result.iloc[-1]

        summaries.append(
            {
                "scenario": row["scenario"],
                "final_p1": final["p1"],
                "final_p2": final["p2"],
                "final_delta_p": final["delta_p"],
            }
        )

    print(pd.DataFrame(summaries).round(4).to_string(index=False))


if __name__ == "__main__":
    main()
