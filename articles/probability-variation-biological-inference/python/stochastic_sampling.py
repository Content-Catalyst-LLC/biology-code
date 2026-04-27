"""
Stochastic sampling workflow.

Run:
    python python/stochastic_sampling.py
"""

import numpy as np
import pandas as pd


def main() -> None:
    rng = np.random.default_rng(42)

    true_probability = 0.68
    sample_sizes = [10, 25, 50, 100, 250, 500]
    n_replicates = 3000

    rows = []

    for n in sample_sizes:
        estimates = rng.binomial(n=n, p=true_probability, size=n_replicates) / n

        rows.append(
            {
                "sample_size": n,
                "mean_estimate": estimates.mean(),
                "sd_estimate": estimates.std(ddof=1),
                "p05": np.quantile(estimates, 0.05),
                "p95": np.quantile(estimates, 0.95),
            }
        )

    print(pd.DataFrame(rows).round(5).to_string(index=False))


if __name__ == "__main__":
    main()
