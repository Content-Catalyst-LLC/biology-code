"""
Likelihood comparison workflow.

Run:
    python python/likelihood_comparison.py
"""

import numpy as np
import pandas as pd

from probability_core import binomial_log_likelihood


def main() -> None:
    successes = 68
    trials = 100

    candidate_probabilities = np.linspace(0.1, 0.9, 81)

    rows = []

    for p in candidate_probabilities:
        rows.append(
            {
                "candidate_probability": p,
                "log_likelihood": binomial_log_likelihood(successes, trials, float(p)),
            }
        )

    result = pd.DataFrame(rows)
    result["delta_log_likelihood"] = result["log_likelihood"] - result["log_likelihood"].max()

    print(result.sort_values("log_likelihood", ascending=False).head(12).round(6).to_string(index=False))


if __name__ == "__main__":
    main()
