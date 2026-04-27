"""
Evaluate conceptual defense activation thresholds.

Run from article directory:
    python python/05_defense_thresholds.py
"""

from pathlib import Path
import pandas as pd

from evolutionary_medicine_core import defense_threshold_summary


ARTICLE_DIR = Path(__file__).resolve().parents[1]
INPUT_PATH = ARTICLE_DIR / "data" / "defense_thresholds.csv"
OUTPUT_PATH = ARTICLE_DIR / "outputs" / "tables" / "defense_threshold_summary.csv"


def main() -> None:
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)

    defenses = pd.read_csv(INPUT_PATH)
    result = defense_threshold_summary(defenses)

    result.to_csv(OUTPUT_PATH, index=False)

    print(result.round(4).to_string(index=False))
    print(f"Saved: {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
