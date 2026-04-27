"""
Summarize time-lapse object tracks.

Run from article directory:
    python python/06_tracking_summary.py
"""

from pathlib import Path

import pandas as pd

from microscopy_image_core import tracking_summary


ARTICLE_DIR = Path(__file__).resolve().parents[1]
INPUT_PATH = ARTICLE_DIR / "data" / "tracks.csv"
OUTPUT_PATH = ARTICLE_DIR / "outputs" / "tables" / "tracking_summary.csv"


def main() -> None:
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)

    tracks = pd.read_csv(INPUT_PATH)
    summary = tracking_summary(tracks)

    summary.to_csv(OUTPUT_PATH, index=False)

    print(summary.round(5).to_string(index=False))
    print(f"Saved: {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
