"""
Calculate stage-specific food loss and waste.

Run from article directory:
    python python/05_food_loss_accounting.py
"""

from pathlib import Path
import pandas as pd

from agriculture_food_systems_core import calculate_food_loss_stages


ARTICLE_DIR = Path(__file__).resolve().parents[1]
INPUT_PATH = ARTICLE_DIR / "data" / "food_loss_stages.csv"
OUTPUT_PATH = ARTICLE_DIR / "outputs" / "tables" / "food_loss_accounting.csv"


def main() -> None:
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)

    loss = pd.read_csv(INPUT_PATH)
    result = calculate_food_loss_stages(loss)

    result.to_csv(OUTPUT_PATH, index=False)

    print(result.round(4).to_string(index=False))
    print(f"Saved: {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
