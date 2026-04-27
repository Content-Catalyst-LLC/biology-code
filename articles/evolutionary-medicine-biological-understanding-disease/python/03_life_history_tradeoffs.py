"""
Summarize life-history allocation trade-offs.

Run from article directory:
    python python/03_life_history_tradeoffs.py
"""

from pathlib import Path
import pandas as pd

from evolutionary_medicine_core import life_history_tradeoffs


ARTICLE_DIR = Path(__file__).resolve().parents[1]
INPUT_PATH = ARTICLE_DIR / "data" / "life_history_allocation.csv"
OUTPUT_PATH = ARTICLE_DIR / "outputs" / "tables" / "life_history_tradeoffs.csv"


def main() -> None:
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)

    allocation = pd.read_csv(INPUT_PATH)
    result = life_history_tradeoffs(allocation)

    result.to_csv(OUTPUT_PATH, index=False)

    print(result.round(4).to_string(index=False))
    print(f"Saved: {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
