"""
Extract object-level features from synthetic segmentation mask.

Run from article directory:
    python python/03_object_feature_extraction.py
"""

from pathlib import Path
import subprocess
import sys

import pandas as pd

from microscopy_image_core import approximate_object_assignment, extract_object_features


ARTICLE_DIR = Path(__file__).resolve().parents[1]
MASK_PATH = ARTICLE_DIR / "outputs" / "tables" / "segmentation_mask.csv"
OBJECTS_PATH = ARTICLE_DIR / "data" / "synthetic_objects.csv"
ASSIGNED_PATH = ARTICLE_DIR / "outputs" / "tables" / "assigned_foreground_pixels.csv"
OUTPUT_PATH = ARTICLE_DIR / "outputs" / "tables" / "object_features.csv"


def ensure_mask() -> None:
    if not MASK_PATH.exists():
        subprocess.run([sys.executable, str(ARTICLE_DIR / "python" / "02_threshold_segmentation.py")], check=True)


def main() -> None:
    ASSIGNED_PATH.parent.mkdir(parents=True, exist_ok=True)
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)
    ensure_mask()

    mask = pd.read_csv(MASK_PATH)
    objects = pd.read_csv(OBJECTS_PATH)

    assigned = approximate_object_assignment(mask, objects)
    features = extract_object_features(assigned)

    assigned.to_csv(ASSIGNED_PATH, index=False)
    features.to_csv(OUTPUT_PATH, index=False)

    print(features.round(5).to_string(index=False))
    print(f"Saved: {ASSIGNED_PATH}")
    print(f"Saved: {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
