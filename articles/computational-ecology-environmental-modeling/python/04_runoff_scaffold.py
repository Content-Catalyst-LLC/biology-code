"""
Calculate simplified runoff by environmental grid cell.

Run from article directory:
    python python/04_runoff_scaffold.py
"""

from pathlib import Path

import pandas as pd

from computational_ecology_core import runoff_mm


ARTICLE_DIR = Path(__file__).resolve().parents[1]
INPUT_PATH = ARTICLE_DIR / "data" / "environmental_grid.csv"
OUTPUT_PATH = ARTICLE_DIR / "outputs" / "tables" / "runoff_scaffold.csv"


def main() -> None:
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)

    grid = pd.read_csv(INPUT_PATH)
    grid["runoff_mm"] = grid.apply(runoff_mm, axis=1)

    grid.to_csv(OUTPUT_PATH, index=False)

    print(grid.round(5).to_string(index=False))
    print(f"Saved: {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
