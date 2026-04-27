"""
Calculate host-burden scores for engineered biological systems.

Run from article directory:
    python python/03_host_burden.py
"""

from pathlib import Path
import pandas as pd

from synthetic_biology_core import host_burden_score


ARTICLE_DIR = Path(__file__).resolve().parents[1]
INPUT_PATH = ARTICLE_DIR / "data" / "host_burden.csv"
OUTPUT_PATH = ARTICLE_DIR / "outputs" / "tables" / "host_burden_scores.csv"


def main() -> None:
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)

    burden = pd.read_csv(INPUT_PATH)
    result = host_burden_score(burden)

    result.to_csv(OUTPUT_PATH, index=False)

    print(result.round(4).to_string(index=False))
    print(f"Saved: {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
