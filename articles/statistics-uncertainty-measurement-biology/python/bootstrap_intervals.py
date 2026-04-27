"""
Bootstrap confidence interval workflow.

Run:
    python python/bootstrap_intervals.py
"""

from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
DATA_PATH = ARTICLE_DIR / "data" / "measurements.csv"


def bootstrap_mean(values, n_bootstrap=5000, seed=42):
    rng = np.random.default_rng(seed)
    arr = np.asarray(values, dtype=float)
    boot = np.empty(n_bootstrap)

    for i in range(n_bootstrap):
        boot[i] = rng.choice(arr, size=len(arr), replace=True).mean()

    return {
        "observed_mean": arr.mean(),
        "bootstrap_mean": boot.mean(),
        "ci_lower": np.quantile(boot, 0.025),
        "ci_upper": np.quantile(boot, 0.975),
    }


def main() -> None:
    data = pd.read_csv(DATA_PATH)

    rows = []

    for group, group_df in data.groupby("group"):
        result = bootstrap_mean(group_df["value"], n_bootstrap=5000, seed=42)

        rows.append({"group": group, "n": len(group_df), **result})

    print(pd.DataFrame(rows).round(5).to_string(index=False))


if __name__ == "__main__":
    main()
