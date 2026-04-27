"""
Calculate metabolic product yield.

Run from article directory:
    python python/04_metabolic_yield.py
"""

from pathlib import Path
import pandas as pd

from synthetic_biology_core import metabolic_yield


ARTICLE_DIR = Path(__file__).resolve().parents[1]
INPUT_PATH = ARTICLE_DIR / "data" / "metabolic_runs.csv"
OUTPUT_PATH = ARTICLE_DIR / "outputs" / "tables" / "metabolic_yield.csv"


def main() -> None:
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)

    runs = pd.read_csv(INPUT_PATH)
    result = metabolic_yield(runs)

    result.to_csv(OUTPUT_PATH, index=False)

    print(result.round(4).to_string(index=False))
    print(f"Saved: {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
