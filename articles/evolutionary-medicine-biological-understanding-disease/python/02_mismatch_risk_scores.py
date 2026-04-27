"""
Calculate conceptual evolutionary mismatch scores.

Run from article directory:
    python python/02_mismatch_risk_scores.py
"""

from pathlib import Path
import pandas as pd

from evolutionary_medicine_core import mismatch_scores


ARTICLE_DIR = Path(__file__).resolve().parents[1]
INPUT_PATH = ARTICLE_DIR / "data" / "mismatch_exposures.csv"
OUTPUT_PATH = ARTICLE_DIR / "outputs" / "tables" / "mismatch_risk_scores.csv"


def main() -> None:
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)

    exposures = pd.read_csv(INPUT_PATH)
    result = mismatch_scores(exposures)

    result.to_csv(OUTPUT_PATH, index=False)

    print(result.round(4).to_string(index=False))
    print(f"Saved: {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
