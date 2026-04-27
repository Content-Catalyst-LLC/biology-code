"""
Estimate habitat suitability from environmental covariates.

Run from article directory:
    python python/01_habitat_suitability.py
"""

from pathlib import Path

import pandas as pd

from computational_ecology_core import habitat_suitability


ARTICLE_DIR = Path(__file__).resolve().parents[1]
INPUT_PATH = ARTICLE_DIR / "data" / "sites.csv"
OUTPUT_PATH = ARTICLE_DIR / "outputs" / "tables" / "habitat_suitability.csv"


def main() -> None:
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)

    sites = pd.read_csv(INPUT_PATH)
    sites["suitability"] = sites.apply(habitat_suitability, axis=1)
    sites["predicted_presence"] = (sites["suitability"] >= 0.5).astype(int)

    sites.to_csv(OUTPUT_PATH, index=False)

    print(sites.round(5).to_string(index=False))
    print(f"Saved: {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
