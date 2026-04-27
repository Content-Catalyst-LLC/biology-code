"""
Variance components workflow.

Run:
    python python/variance_components.py
"""

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
DATA_PATH = ARTICLE_DIR / "data" / "biological_technical_replicates.csv"


def main() -> None:
    data = pd.read_csv(DATA_PATH)

    unit_means = data.groupby("biological_unit")["measurement"].mean()

    between_unit_variance = unit_means.var(ddof=1)
    within_unit_variance = data.groupby("biological_unit")["measurement"].var(ddof=1).mean()

    summary = pd.DataFrame(
        {
            "between_biological_unit_variance": [between_unit_variance],
            "within_technical_variance": [within_unit_variance],
            "variance_ratio_biological_to_technical": [between_unit_variance / within_unit_variance],
        }
    )

    print(summary.round(5).to_string(index=False))


if __name__ == "__main__":
    main()
