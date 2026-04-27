"""
Apply threshold segmentation to synthetic microscopy image.

Run from article directory:
    python python/02_threshold_segmentation.py
"""

from pathlib import Path
import subprocess
import sys

import pandas as pd

from microscopy_image_core import threshold_segmentation


ARTICLE_DIR = Path(__file__).resolve().parents[1]
IMAGE_PATH = ARTICLE_DIR / "outputs" / "tables" / "synthetic_image_pixels.csv"
OUTPUT_PATH = ARTICLE_DIR / "outputs" / "tables" / "segmentation_mask.csv"


def ensure_image() -> None:
    if not IMAGE_PATH.exists():
        subprocess.run([sys.executable, str(ARTICLE_DIR / "python" / "01_generate_synthetic_microscopy.py")], check=True)


def main() -> None:
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)
    ensure_image()

    image = pd.read_csv(IMAGE_PATH)
    channel_a = image[image["channel"] == "A"].copy()
    mask = threshold_segmentation(channel_a, threshold=65.0)

    mask.to_csv(OUTPUT_PATH, index=False)

    print(mask.head().round(5).to_string(index=False))
    print("foreground_pixels:", int(mask["mask"].sum()))
    print(f"Saved: {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
