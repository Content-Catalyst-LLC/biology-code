"""
Historical timeline summary workflow.

Run:
    python python/historical_timeline.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
TIMELINE_PATH = ARTICLE_DIR / "data" / "historical_milestones.csv"


def main() -> None:
    timeline = pd.read_csv(TIMELINE_PATH)

    timeline["century"] = ((timeline["year"] - 1) // 100 + 1).astype(int)

    domain_summary = (
        timeline.groupby("domain")
        .agg(
            first_year=("year", "min"),
            last_year=("year", "max"),
            n_milestones=("milestone", "count"),
        )
        .reset_index()
        .sort_values(["first_year", "domain"])
    )

    century_summary = (
        timeline.groupby("century")
        .agg(
            first_year=("year", "min"),
            last_year=("year", "max"),
            n_milestones=("milestone", "count"),
            domains=("domain", lambda x: ", ".join(sorted(set(x)))),
        )
        .reset_index()
        .sort_values("century")
    )

    print(domain_summary.to_string(index=False))
    print(century_summary.to_string(index=False))


if __name__ == "__main__":
    main()
