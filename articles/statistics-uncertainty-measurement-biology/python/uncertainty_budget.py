"""
Uncertainty budget workflow.

Run:
    python python/uncertainty_budget.py
"""

from pathlib import Path

import pandas as pd

from statistics_measurement_core import combined_standard_uncertainty


ARTICLE_DIR = Path(__file__).resolve().parents[1]
DATA_PATH = ARTICLE_DIR / "data" / "uncertainty_components.csv"


def main() -> None:
    components = pd.read_csv(DATA_PATH)

    combined = combined_standard_uncertainty(components["standard_uncertainty"])
    expanded = 2 * combined

    summary = pd.DataFrame(
        {
            "combined_standard_uncertainty": [combined],
            "coverage_factor": [2],
            "expanded_uncertainty": [expanded],
            "unit": [components["unit"].iloc[0]],
        }
    )

    print(components.round(5).to_string(index=False))
    print(summary.round(5).to_string(index=False))


if __name__ == "__main__":
    main()
