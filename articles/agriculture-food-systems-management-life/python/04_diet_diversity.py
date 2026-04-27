"""
Calculate simplified diet-diversity scores.

Run from article directory:
    python python/04_diet_diversity.py
"""

from pathlib import Path
import pandas as pd

from agriculture_food_systems_core import calculate_diet_diversity


ARTICLE_DIR = Path(__file__).resolve().parents[1]
INPUT_PATH = ARTICLE_DIR / "data" / "diet_diversity.csv"
OUTPUT_PATH = ARTICLE_DIR / "outputs" / "tables" / "diet_diversity_scores.csv"


def main() -> None:
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)

    diet = pd.read_csv(INPUT_PATH)
    result = calculate_diet_diversity(diet)

    result.to_csv(OUTPUT_PATH, index=False)

    print(result.to_string(index=False))
    print(f"Saved: {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
