"""
Power simulation workflow.

Run:
    python python/power_simulation.py
"""

from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
POWER_PATH = ARTICLE_DIR / "data" / "power_scenarios.csv"


def simulate_power(sample_size: int, effect_size: float, sigma: float, alpha: float, n_sim: int, seed: int) -> float:
    """Approximate two-group power using a normal-approximation z threshold."""

    rng = np.random.default_rng(seed)
    significant = 0

    threshold = 1.96 if abs(alpha - 0.05) < 1e-9 else 1.96

    for _ in range(n_sim):
        control = rng.normal(loc=0.0, scale=sigma, size=sample_size)
        treated = rng.normal(loc=effect_size, scale=sigma, size=sample_size)

        difference = treated.mean() - control.mean()
        standard_error = np.sqrt(control.var(ddof=1) / sample_size + treated.var(ddof=1) / sample_size)

        if standard_error > 0 and abs(difference / standard_error) > threshold:
            significant += 1

    return significant / n_sim


def main() -> None:
    scenarios = pd.read_csv(POWER_PATH)

    rows = []

    for _, row in scenarios.iterrows():
        rows.append(
            {
                "scenario": row["scenario"],
                "sample_size_per_group": row["sample_size_per_group"],
                "effect_size": row["effect_size"],
                "sigma": row["sigma"],
                "estimated_power": simulate_power(
                    int(row["sample_size_per_group"]),
                    float(row["effect_size"]),
                    float(row["sigma"]),
                    float(row["alpha"]),
                    int(row["n_sim"]),
                    int(row["seed"]),
                ),
            }
        )

    print(pd.DataFrame(rows).round(5).to_string(index=False))


if __name__ == "__main__":
    main()
