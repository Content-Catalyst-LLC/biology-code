"""
Measurement uncertainty budget workflow.

Run:
    python python/uncertainty_budget.py
"""

from pathlib import Path

import pandas as pd

from reproducibility_core import uncertainty_budget


ARTICLE_DIR = Path(__file__).resolve().parents[1]
DATA_PATH = ARTICLE_DIR / "data" / "uncertainty_components.csv"


def main() -> None:
    components = pd.read_csv(DATA_PATH)
    summary = uncertainty_budget(components, coverage_factor=2.0)

    print(components.to_string(index=False))
    print(summary.round(5).to_string(index=False))


if __name__ == "__main__":
    main()
