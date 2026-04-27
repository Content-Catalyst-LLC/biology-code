"""
Calculate transparent ethical-review scores.

Run from article directory:
    python python/01_ethical_review_scores.py
"""

from pathlib import Path
import pandas as pd

from biology_ethics_core import ethical_review_scores


ARTICLE_DIR = Path(__file__).resolve().parents[1]
INPUT_PATH = ARTICLE_DIR / "data" / "biology_ethics_projects.csv"
OUTPUT_PATH = ARTICLE_DIR / "outputs" / "tables" / "ethical_review_scores.csv"


def main() -> None:
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)

    projects = pd.read_csv(INPUT_PATH)
    result = ethical_review_scores(projects)

    result.to_csv(OUTPUT_PATH, index=False)

    print(result.round(4).to_string(index=False))
    print(f"Saved: {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
