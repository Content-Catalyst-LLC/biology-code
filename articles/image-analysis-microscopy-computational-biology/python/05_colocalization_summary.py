"""
Calculate colocalization summary metrics.

Run from article directory:
    python python/05_colocalization_summary.py
"""

from pathlib import Path

import pandas as pd

from microscopy_image_core import colocalization_summary


ARTICLE_DIR = Path(__file__).resolve().parents[1]
INPUT_PATH = ARTICLE_DIR / "data" / "colocalization_pixels.csv"
OUTPUT_PATH = ARTICLE_DIR / "outputs" / "tables" / "colocalization_summary.csv"


def main() -> None:
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)

    pixels = pd.read_csv(INPUT_PATH)
    summary = colocalization_summary(pixels, threshold_a=30.0, threshold_b=30.0)

    summary.to_csv(OUTPUT_PATH, index=False)

    print(summary.round(5).to_string(index=False))
    print(f"Saved: {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
