"""
Calculate ecological-risk and reversibility-adjusted risk.

Run from article directory:
    python python/04_ecological_risk.py
"""

from pathlib import Path
import pandas as pd

from biology_ethics_core import ecological_risk_scores


ARTICLE_DIR = Path(__file__).resolve().parents[1]
INPUT_PATH = ARTICLE_DIR / "data" / "ecological_risk.csv"
OUTPUT_PATH = ARTICLE_DIR / "outputs" / "tables" / "ecological_risk_scores.csv"


def main() -> None:
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)

    data = pd.read_csv(INPUT_PATH)
    result = ecological_risk_scores(data)

    result.to_csv(OUTPUT_PATH, index=False)

    print(result.round(4).to_string(index=False))
    print(f"Saved: {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
