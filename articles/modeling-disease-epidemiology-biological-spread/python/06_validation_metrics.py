"""
Calculate forecast validation metrics.

Run from article directory:
    python python/06_validation_metrics.py
"""

from pathlib import Path

import pandas as pd

from epidemiology_core import validation_metrics


ARTICLE_DIR = Path(__file__).resolve().parents[1]
INPUT_PATH = ARTICLE_DIR / "data" / "forecast_validation.csv"
OUTPUT_PATH = ARTICLE_DIR / "outputs" / "tables" / "validation_metrics.csv"


def main() -> None:
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)

    validation = pd.read_csv(INPUT_PATH)
    metrics = validation_metrics(validation["observed_cases"], validation["predicted_cases"])

    metrics.to_csv(OUTPUT_PATH, index=False)

    print(metrics.round(5).to_string(index=False))
    print(f"Saved: {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
