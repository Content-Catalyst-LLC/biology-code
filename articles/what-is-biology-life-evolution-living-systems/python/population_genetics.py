"""
Population-genetics workflow.

Run:
    python python/population_genetics.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd

from biology_core import hardy_weinberg


ARTICLE_DIR = Path(__file__).resolve().parents[1]
HW_PATH = ARTICLE_DIR / "data" / "hardy_weinberg_cases.csv"


def main() -> None:
    cases = pd.read_csv(HW_PATH)

    rows = []

    for _, row in cases.iterrows():
        frequencies = hardy_weinberg(float(row["allele_frequency_p"]))

        rows.append(
            {
                "case_id": row["case_id"],
                "p": row["allele_frequency_p"],
                "q": 1 - row["allele_frequency_p"],
                "AA": frequencies["AA"],
                "Aa": frequencies["Aa"],
                "aa": frequencies["aa"],
            }
        )

    print(pd.DataFrame(rows).round(4).to_string(index=False))


if __name__ == "__main__":
    main()
