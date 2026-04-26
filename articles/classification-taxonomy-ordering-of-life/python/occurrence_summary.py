"""
Occurrence-record summary workflow.

Run:
    python python/occurrence_summary.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
OCC_PATH = ARTICLE_DIR / "data" / "occurrence_records.csv"


def main() -> None:
    records = pd.read_csv(OCC_PATH)

    taxon_summary = (
        records.groupby("taxon")
        .agg(
            n_records=("record_id", "count"),
            mean_identification_confidence=("identification_confidence", "mean"),
            countries=("country", lambda x: ", ".join(sorted(set(x)))),
            basis_types=("basis_of_record", lambda x: ", ".join(sorted(set(x)))),
        )
        .reset_index()
        .sort_values("n_records", ascending=False)
    )

    country_summary = (
        records.groupby("country")
        .agg(
            n_records=("record_id", "count"),
            n_taxa=("taxon", "nunique"),
            mean_identification_confidence=("identification_confidence", "mean"),
        )
        .reset_index()
        .sort_values("n_records", ascending=False)
    )

    print(taxon_summary.round(3).to_string(index=False))
    print(country_summary.round(3).to_string(index=False))


if __name__ == "__main__":
    main()
