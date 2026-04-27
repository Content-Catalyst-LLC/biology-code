"""
Calculate justice-adjusted benefit.

Run from article directory:
    python python/03_justice_adjusted_benefit.py
"""

from pathlib import Path
import pandas as pd

from biology_ethics_core import justice_adjusted_benefit


ARTICLE_DIR = Path(__file__).resolve().parents[1]
INPUT_PATH = ARTICLE_DIR / "data" / "justice_benefit.csv"
OUTPUT_PATH = ARTICLE_DIR / "outputs" / "tables" / "justice_adjusted_benefit.csv"


def main() -> None:
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)

    data = pd.read_csv(INPUT_PATH)
    result = justice_adjusted_benefit(data)

    result.to_csv(OUTPUT_PATH, index=False)

    print(result.round(4).to_string(index=False))
    print(f"Saved: {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
