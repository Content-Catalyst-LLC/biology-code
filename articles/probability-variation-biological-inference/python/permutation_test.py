"""
Permutation test workflow.

Run:
    python python/permutation_test.py
"""

from pathlib import Path

import pandas as pd

from probability_core import permutation_test_mean_difference


ARTICLE_DIR = Path(__file__).resolve().parents[1]
MEASURE_PATH = ARTICLE_DIR / "data" / "biological_measurements.csv"


def main() -> None:
    data = pd.read_csv(MEASURE_PATH)

    control = data.loc[data["group"] == "control", "value"].to_numpy()
    treated = data.loc[data["group"] == "treated", "value"].to_numpy()

    result = permutation_test_mean_difference(control, treated, n_permutations=10000, seed=42)

    print(pd.DataFrame([result]).round(6).to_string(index=False))


if __name__ == "__main__":
    main()
