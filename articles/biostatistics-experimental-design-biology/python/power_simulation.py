"""
Power simulation workflow.

Run:
    python python/power_simulation.py
"""

from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
DATA_PATH = ARTICLE_DIR / "data" / "power_scenarios.csv"


def simulate_power(sample_size: int, effect_size: float, sigma: float, n_sim: int, seed: int) -> float:
    """Approximate two-group power using a z threshold."""

    rng = np.random.default_rng(seed)
    significant = 0

    for _ in range(n_sim):
        control = rng.normal(loc=0.0, scale=sigma, size=sample_size)
        treated = rng.normal(loc=effect_size, scale=sigma, size=sample_size)

        difference = treated.mean() - control.mean()
        se = np.sqrt(control.var(ddof=1) / sample_size + treated.var(ddof=1) / sample_size)

        if se > 0 and abs(difference / se) > 1.96:
            significant += 1

    return significant / n_sim


def main() -> None:
    scenarios = pd.read_csv(DATA_PATH)

    rows = []

    for _, row in scenarios.iterrows():
        rows.append(
            {
                "scenario": row["scenario"],
                "sample_size_per_group": row["sample_size_per_group"],
                "effect_size": row["effect_size"],
                "sigma": row["sigma"],
                "estimated_power": simulate_power(
                    sample_size=int(row["sample_size_per_group"]),
                    effect_size=float(row["effect_size"]),
                    sigma=float(row["sigma"]),
                    n_sim=int(row["n_sim"]),
                    seed=int(row["seed"]),
                ),
            }
        )

    print(pd.DataFrame(rows).round(5).to_string(index=False))


if __name__ == "__main__":
    main()
