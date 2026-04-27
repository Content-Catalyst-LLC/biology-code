"""
Generate synthetic microscopy-like image pixels.

Run from article directory:
    python python/01_generate_synthetic_microscopy.py
"""

from pathlib import Path

import pandas as pd

from microscopy_image_core import generate_synthetic_image


ARTICLE_DIR = Path(__file__).resolve().parents[1]
OBJECTS_PATH = ARTICLE_DIR / "data" / "synthetic_objects.csv"
METADATA_PATH = ARTICLE_DIR / "data" / "microscopy_metadata.csv"
OUTPUT_PATH = ARTICLE_DIR / "outputs" / "tables" / "synthetic_image_pixels.csv"


def main() -> None:
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)

    objects = pd.read_csv(OBJECTS_PATH)
    metadata = pd.read_csv(METADATA_PATH).iloc[0]

    image_a = generate_synthetic_image(
        objects=objects,
        width=int(metadata["width"]),
        height=int(metadata["height"]),
        channel="A",
        background=18.0,
    )

    image_b = generate_synthetic_image(
        objects=objects,
        width=int(metadata["width"]),
        height=int(metadata["height"]),
        channel="B",
        background=16.0,
    )

    result = pd.concat([image_a, image_b], ignore_index=True)
    result.to_csv(OUTPUT_PATH, index=False)

    print(result.head().round(5).to_string(index=False))
    print(f"Saved: {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
