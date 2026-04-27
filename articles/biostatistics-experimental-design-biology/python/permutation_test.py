"""
Permutation test workflow.

Run:
    python python/permutation_test.py
"""

from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
DATA_PATH = ARTICLE_DIR / "data" / "two_group_measurements.csv"


def main() -> None:
    rng = np.random.default_rng(42)

    data = pd.read_csv(DATA_PATH)

    control = data.loc[data["group"] == "control", "value"].to_numpy()
    treated = data.loc[data["group"] == "treated", "value"].to_numpy()

    observed_difference = treated.mean() - control.mean()
    combined = np.concatenate([control, treated])
    n_control = len(control)

    n_permutations = 10000
    null = np.empty(n_permutations)

    for i in range(n_permutations):
        shuffled = rng.permutation(combined)
        null[i] = shuffled[n_control:].mean() - shuffled[:n_control].mean()

    p_value = np.mean(np.abs(null) >= abs(observed_difference))

    result = pd.DataFrame(
        {
            "observed_difference": [observed_difference],
            "permutation_p_value": [p_value],
            "null_mean": [null.mean()],
            "null_sd": [null.std(ddof=1)],
        }
    )

    print(result.round(6).to_string(index=False))


if __name__ == "__main__":
    main()
