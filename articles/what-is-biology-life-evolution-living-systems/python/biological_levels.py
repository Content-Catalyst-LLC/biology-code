"""
Biological levels workflow.

Run:
    python python/biological_levels.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
LEVELS_PATH = ARTICLE_DIR / "data" / "biological_levels.csv"


def main() -> None:
    levels = pd.read_csv(LEVELS_PATH)

    levels["n_related_fields"] = levels["related_fields"].str.split(";").apply(len)

    print(levels.to_string(index=False))


if __name__ == "__main__":
    main()
