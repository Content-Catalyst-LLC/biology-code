"""
Calculate biosensor signal-to-noise ratios.

Run from article directory:
    python python/02_biosensor_signal_to_noise.py
"""

from pathlib import Path
import pandas as pd

from synthetic_biology_core import biosensor_signal_to_noise


ARTICLE_DIR = Path(__file__).resolve().parents[1]
INPUT_PATH = ARTICLE_DIR / "data" / "biosensor_measurements.csv"
OUTPUT_PATH = ARTICLE_DIR / "outputs" / "tables" / "biosensor_signal_to_noise.csv"


def main() -> None:
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)

    measurements = pd.read_csv(INPUT_PATH)
    result = biosensor_signal_to_noise(measurements)

    result.to_csv(OUTPUT_PATH, index=False)

    print(result.round(4).to_string(index=False))
    print(f"Saved: {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
