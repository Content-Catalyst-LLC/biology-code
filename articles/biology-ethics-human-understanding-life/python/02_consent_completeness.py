"""
Calculate consent-completeness indicators.

Run from article directory:
    python python/02_consent_completeness.py
"""

from pathlib import Path
import pandas as pd

from biology_ethics_core import consent_completeness


ARTICLE_DIR = Path(__file__).resolve().parents[1]
INPUT_PATH = ARTICLE_DIR / "data" / "consent_records.csv"
OUTPUT_PATH = ARTICLE_DIR / "outputs" / "tables" / "consent_completeness.csv"


def main() -> None:
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)

    consent = pd.read_csv(INPUT_PATH)
    result = consent_completeness(consent)

    result.to_csv(OUTPUT_PATH, index=False)

    print(result.round(4).to_string(index=False))
    print(f"Saved: {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
