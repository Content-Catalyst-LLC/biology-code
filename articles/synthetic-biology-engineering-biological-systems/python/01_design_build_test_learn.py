"""
Score synthetic biology designs in a design-build-test-learn scaffold.

Run from article directory:
    python python/01_design_build_test_learn.py
"""

from pathlib import Path
import pandas as pd

from synthetic_biology_core import score_designs


ARTICLE_DIR = Path(__file__).resolve().parents[1]
INPUT_PATH = ARTICLE_DIR / "data" / "synthetic_biology_designs.csv"
OUTPUT_PATH = ARTICLE_DIR / "outputs" / "tables" / "dbtl_engineering_scores.csv"


def main() -> None:
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)

    designs = pd.read_csv(INPUT_PATH)
    scored = score_designs(designs)

    scored.to_csv(OUTPUT_PATH, index=False)

    print(scored.round(4).to_string(index=False))
    print(f"Saved: {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
