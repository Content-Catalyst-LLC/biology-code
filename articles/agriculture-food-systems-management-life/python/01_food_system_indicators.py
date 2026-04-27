"""
Calculate agriculture and food-system indicators.

Run from article directory:
    python python/01_food_system_indicators.py
"""

from pathlib import Path
import pandas as pd

from agriculture_food_systems_core import calculate_food_system_indicators


ARTICLE_DIR = Path(__file__).resolve().parents[1]
INPUT_PATH = ARTICLE_DIR / "data" / "production_systems.csv"
OUTPUT_PATH = ARTICLE_DIR / "outputs" / "tables" / "food_system_indicators.csv"


def main() -> None:
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)

    systems = pd.read_csv(INPUT_PATH)
    indicators = calculate_food_system_indicators(systems)

    indicators.to_csv(OUTPUT_PATH, index=False)

    print(indicators.round(5).to_string(index=False))
    print(f"Saved: {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
