"""
Calibration curve workflow.

Run:
    python python/calibration_curve.py
"""

from pathlib import Path

import pandas as pd

from statistics_measurement_core import concentration_from_response, fit_linear_calibration


ARTICLE_DIR = Path(__file__).resolve().parents[1]
DATA_PATH = ARTICLE_DIR / "data" / "calibration_standards.csv"


def main() -> None:
    standards = pd.read_csv(DATA_PATH)

    fit = fit_linear_calibration(standards["concentration"], standards["response"])

    unknown_response = 6.25
    estimated_concentration = concentration_from_response(unknown_response, fit)

    summary = pd.DataFrame(
        {
            "intercept": [fit.intercept],
            "slope": [fit.slope],
            "r_squared": [fit.r_squared],
            "unknown_response": [unknown_response],
            "estimated_concentration": [estimated_concentration],
        }
    )

    print(summary.round(5).to_string(index=False))


if __name__ == "__main__":
    main()
