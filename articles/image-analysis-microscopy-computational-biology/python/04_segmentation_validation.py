"""
Calculate segmentation validation metrics.

Run from article directory:
    python python/04_segmentation_validation.py
"""

from pathlib import Path

import pandas as pd

from microscopy_image_core import segmentation_metrics


ARTICLE_DIR = Path(__file__).resolve().parents[1]
INPUT_PATH = ARTICLE_DIR / "data" / "segmentation_validation_pixels.csv"
OUTPUT_PATH = ARTICLE_DIR / "outputs" / "tables" / "segmentation_validation_metrics.csv"


def main() -> None:
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)

    validation_pixels = pd.read_csv(INPUT_PATH)
    metrics = segmentation_metrics(validation_pixels)

    metrics.to_csv(OUTPUT_PATH, index=False)

    print(metrics.round(5).to_string(index=False))
    print(f"Saved: {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
