"""
Bootstrap uncertainty workflow.

Run:
    python python/bootstrap_uncertainty.py
"""

from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
DATA_PATH = ARTICLE_DIR / "data" / "two_group_measurements.csv"


def bootstrap_mean_difference(control, treated, n_bootstrap=5000, seed=42):
    rng = np.random.default_rng(seed)
    boot = np.empty(n_bootstrap)

    for i in range(n_bootstrap):
        c = rng.choice(control, size=len(control), replace=True)
        t = rng.choice(treated, size=len(treated), replace=True)
        boot[i] = t.mean() - c.mean()

    return {
        "bootstrap_mean_difference": boot.mean(),
        "ci_lower": np.quantile(boot, 0.025),
        "ci_upper": np.quantile(boot, 0.975),
    }


def main() -> None:
    data = pd.read_csv(DATA_PATH)

    control = data.loc[data["group"] == "control", "value"].to_numpy()
    treated = data.loc[data["group"] == "treated", "value"].to_numpy()

    result = bootstrap_mean_difference(control, treated)

    print(pd.DataFrame([result]).round(5).to_string(index=False))


if __name__ == "__main__":
    main()
