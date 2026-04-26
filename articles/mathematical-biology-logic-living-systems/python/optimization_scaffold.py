"""
Simple grid-search optimization scaffold for biological model fitting.

Run:
    python python/optimization_scaffold.py
"""

import numpy as np
import pandas as pd

from math_biology_core import LogisticParameters, logistic_growth


def sum_squared_error(observed: np.ndarray, predicted: np.ndarray) -> float:
    return float(np.sum((observed - predicted) ** 2))


def main() -> None:
    observed_time = np.array([0, 5, 10, 15, 20, 25, 30, 35, 40], dtype=float)
    observed_population = np.array([100, 310, 690, 1120, 1500, 1740, 1875, 1940, 1975], dtype=float)

    candidates = []

    for r in np.linspace(0.20, 0.40, 41):
        for k in np.linspace(1600, 2400, 41):
            params = LogisticParameters(initial_population=100, growth_rate=float(r), carrying_capacity=float(k))
            predicted = logistic_growth(observed_time, params)

            candidates.append(
                {
                    "growth_rate": r,
                    "carrying_capacity": k,
                    "sse": sum_squared_error(observed_population, predicted),
                }
            )

    result = pd.DataFrame(candidates).sort_values("sse").head(10)

    print(result.round(6).to_string(index=False))


if __name__ == "__main__":
    main()
