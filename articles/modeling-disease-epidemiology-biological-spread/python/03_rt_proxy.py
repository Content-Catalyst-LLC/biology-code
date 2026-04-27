"""
Estimate a simple growth-rate and Rt proxy scaffold.

Run from article directory:
    python python/03_rt_proxy.py
"""

from pathlib import Path

import pandas as pd

from epidemiology_core import rt_proxy


ARTICLE_DIR = Path(__file__).resolve().parents[1]
INPUT_PATH = ARTICLE_DIR / "data" / "incidence.csv"
OUTPUT_PATH = ARTICLE_DIR / "outputs" / "tables" / "rt_proxy.csv"


def main() -> None:
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)

    incidence = pd.read_csv(INPUT_PATH)
    result = rt_proxy(incidence, generation_interval_days=4.0)

    result.to_csv(OUTPUT_PATH, index=False)

    print(result.round(5).to_string(index=False))
    print(f"Saved: {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
