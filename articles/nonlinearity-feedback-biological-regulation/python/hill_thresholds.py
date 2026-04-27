"""
Hill-function threshold and cooperativity scenarios.

Run:
    python python/hill_thresholds.py
"""

from pathlib import Path

import numpy as np
import pandas as pd

from nonlinear_feedback_core import hill_response


ARTICLE_DIR = Path(__file__).resolve().parents[1]
DATA_PATH = ARTICLE_DIR / "data" / "hill_scenarios.csv"


def main() -> None:
    scenarios = pd.read_csv(DATA_PATH)
    signals = np.array([20, 40, 60, 80], dtype=float)

    rows = []

    for _, row in scenarios.iterrows():
        response = hill_response(signals, row["k_half"], row["hill_coefficient"])
        rows.append(
            {
                "scenario": row["scenario"],
                "hill_coefficient": row["hill_coefficient"],
                "response_at_20": response[0],
                "response_at_40": response[1],
                "response_at_60": response[2],
                "response_at_80": response[3],
            }
        )

    print(pd.DataFrame(rows).round(5).to_string(index=False))


if __name__ == "__main__":
    main()
