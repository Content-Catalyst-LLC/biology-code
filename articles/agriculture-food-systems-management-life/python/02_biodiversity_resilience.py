"""
Calculate biodiversity-resilience scores for synthetic food systems.

Run from article directory:
    python python/02_biodiversity_resilience.py
"""

from pathlib import Path
import pandas as pd

from agriculture_food_systems_core import calculate_biodiversity_resilience


ARTICLE_DIR = Path(__file__).resolve().parents[1]
INPUT_PATH = ARTICLE_DIR / "data" / "biodiversity_resilience.csv"
OUTPUT_PATH = ARTICLE_DIR / "outputs" / "tables" / "biodiversity_resilience_scores.csv"


def main() -> None:
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)

    data = pd.read_csv(INPUT_PATH)
    result = calculate_biodiversity_resilience(data)

    result.to_csv(OUTPUT_PATH, index=False)

    print(result.round(4).to_string(index=False))
    print(f"Saved: {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
