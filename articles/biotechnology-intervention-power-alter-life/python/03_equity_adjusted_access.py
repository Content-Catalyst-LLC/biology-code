"""
Calculate equity-adjusted access for synthetic biotechnology interventions.

Run from article directory:
    python python/03_equity_adjusted_access.py
"""

from pathlib import Path
import pandas as pd

from biotechnology_intervention_core import equity_adjusted_access


ARTICLE_DIR = Path(__file__).resolve().parents[1]
INPUT_PATH = ARTICLE_DIR / "data" / "access_equity.csv"
OUTPUT_PATH = ARTICLE_DIR / "outputs" / "tables" / "equity_adjusted_access.csv"


def main() -> None:
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)

    access = pd.read_csv(INPUT_PATH)
    result = equity_adjusted_access(access)

    result.to_csv(OUTPUT_PATH, index=False)

    print(result.round(4).to_string(index=False))
    print(f"Saved: {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
