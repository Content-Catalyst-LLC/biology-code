"""
Adjust reported cases using estimated reporting completeness.

Run from article directory:
    python python/05_reporting_delay_adjustment.py
"""

from pathlib import Path

import pandas as pd

from epidemiology_core import reporting_delay_adjustment


ARTICLE_DIR = Path(__file__).resolve().parents[1]
INPUT_PATH = ARTICLE_DIR / "data" / "incidence.csv"
OUTPUT_PATH = ARTICLE_DIR / "outputs" / "tables" / "reporting_delay_adjustment.csv"


def main() -> None:
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)

    incidence = pd.read_csv(INPUT_PATH)
    result = reporting_delay_adjustment(incidence)

    result.to_csv(OUTPUT_PATH, index=False)

    print(result.round(5).to_string(index=False))
    print(f"Saved: {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
