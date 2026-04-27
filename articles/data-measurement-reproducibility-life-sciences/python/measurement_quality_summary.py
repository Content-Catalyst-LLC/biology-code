"""
Measurement quality summary workflow.

Run:
    python python/measurement_quality_summary.py
"""

from pathlib import Path

import pandas as pd

from reproducibility_core import measurement_quality_summary


ARTICLE_DIR = Path(__file__).resolve().parents[1]
DATA_PATH = ARTICLE_DIR / "data" / "measurements.csv"


def main() -> None:
    data = pd.read_csv(DATA_PATH)
    summary = measurement_quality_summary(data)

    print(pd.DataFrame([summary.__dict__]).round(5).to_string(index=False))


if __name__ == "__main__":
    main()
