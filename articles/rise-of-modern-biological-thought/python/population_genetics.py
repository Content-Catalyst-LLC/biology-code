"""
Population-genetics workflows.

Run:
    python python/population_genetics.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd

from modern_biology_core import hardy_weinberg, selection_update


ARTICLE_DIR = Path(__file__).resolve().parents[1]
HW_PATH = ARTICLE_DIR / "data" / "hardy_weinberg_cases.csv"
SELECTION_PATH = ARTICLE_DIR / "data" / "selection_scenarios.csv"


def main() -> None:
    hw_cases = pd.read_csv(HW_PATH)

    hw_rows = []

    for _, row in hw_cases.iterrows():
        freqs = hardy_weinberg(float(row["allele_frequency_p"]))

        hw_rows.append(
            {
                "case_id": row["case_id"],
                "p": row["allele_frequency_p"],
                "AA": freqs["AA"],
                "Aa": freqs["Aa"],
                "aa": freqs["aa"],
            }
        )

    selection_cases = pd.read_csv(SELECTION_PATH)

    selection_rows = []

    for _, row in selection_cases.iterrows():
        p = float(row["p_initial"])

        for generation in range(int(row["generations"]) + 1):
            selection_rows.append(
                {
                    "scenario": row["scenario"],
                    "generation": generation,
                    "p": p,
                }
            )

            p = selection_update(p, row["w_AA"], row["w_Aa"], row["w_aa"])

    selection_df = pd.DataFrame(selection_rows)

    final_selection = (
        selection_df.sort_values(["scenario", "generation"])
        .groupby("scenario")
        .tail(1)
        .reset_index(drop=True)
    )

    print(pd.DataFrame(hw_rows).round(4).to_string(index=False))
    print(final_selection.round(5).to_string(index=False))


if __name__ == "__main__":
    main()
