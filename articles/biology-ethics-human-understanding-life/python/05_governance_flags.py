"""
Summarize governance requirements for biological research projects.

Run from article directory:
    python python/05_governance_flags.py
"""

from pathlib import Path
import pandas as pd

from biology_ethics_core import governance_flags


ARTICLE_DIR = Path(__file__).resolve().parents[1]
INPUT_PATH = ARTICLE_DIR / "data" / "governance_requirements.csv"
OUTPUT_PATH = ARTICLE_DIR / "outputs" / "tables" / "governance_flags.csv"


def main() -> None:
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)

    data = pd.read_csv(INPUT_PATH)
    result = governance_flags(data)

    result.to_csv(OUTPUT_PATH, index=False)

    print(result.to_string(index=False))
    print(f"Saved: {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
