"""
Calculate soil organic carbon change.

Run from article directory:
    python python/03_soil_carbon_change.py
"""

from pathlib import Path
import pandas as pd

from agriculture_food_systems_core import calculate_soil_carbon_change


ARTICLE_DIR = Path(__file__).resolve().parents[1]
INPUT_PATH = ARTICLE_DIR / "data" / "soil_carbon.csv"
OUTPUT_PATH = ARTICLE_DIR / "outputs" / "tables" / "soil_carbon_change.csv"


def main() -> None:
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)

    soil = pd.read_csv(INPUT_PATH)
    result = calculate_soil_carbon_change(soil)

    result.to_csv(OUTPUT_PATH, index=False)

    print(result.round(4).to_string(index=False))
    print(f"Saved: {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
