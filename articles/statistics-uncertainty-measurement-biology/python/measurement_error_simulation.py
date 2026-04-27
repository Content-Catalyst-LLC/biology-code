"""
Measurement error simulation workflow.

Run:
    python python/measurement_error_simulation.py
"""

import numpy as np
import pandas as pd

from statistics_measurement_core import root_mean_squared_error


def main() -> None:
    rng = np.random.default_rng(42)

    n_samples = 200
    true_values = rng.normal(loc=10.0, scale=1.5, size=n_samples)

    systematic_bias = 0.35
    random_error_sd = 0.45

    measured_values = true_values + systematic_bias + rng.normal(
        loc=0.0,
        scale=random_error_sd,
        size=n_samples,
    )

    errors = measured_values - true_values

    summary = pd.DataFrame(
        {
            "true_mean": [true_values.mean()],
            "measured_mean": [measured_values.mean()],
            "mean_error": [errors.mean()],
            "error_sd": [errors.std(ddof=1)],
            "rmse": [root_mean_squared_error(errors)],
        }
    )

    print(summary.round(5).to_string(index=False))


if __name__ == "__main__":
    main()
