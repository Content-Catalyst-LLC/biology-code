"""
Saturating biological response scenarios.

Run:
    python python/saturating_response.py
"""

from pathlib import Path

import numpy as np
import pandas as pd

from nonlinear_feedback_core import saturating_response


ARTICLE_DIR = Path(__file__).resolve().parents[1]
DATA_PATH = ARTICLE_DIR / "data" / "saturating_response_scenarios.csv"


def main() -> None:
    scenarios = pd.read_csv(DATA_PATH)
    signals = np.array([5, 20, 80, 100], dtype=float)

    rows = []

    for _, row in scenarios.iterrows():
        response = saturating_response(signals, row["vmax"], row["k_half"])
        rows.append(
            {
                "scenario": row["scenario"],
                "response_at_5": response[0],
                "response_at_20": response[1],
                "response_at_80": response[2],
                "response_at_100": response[3],
            }
        )

    print(pd.DataFrame(rows).round(5).to_string(index=False))


if __name__ == "__main__":
    main()
