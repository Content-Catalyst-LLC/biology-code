"""
Stochastic lineage survivorship under crisis.

Run:
    python python/stochastic_survivorship.py
"""

from __future__ import annotations

import numpy as np
import pandas as pd


RNG = np.random.default_rng(42)


def simulate_survival(initial: int = 120, survive_prob: float = 0.25, n_iter: int = 1000) -> pd.DataFrame:
    """Simulate stochastic lineage survival under crisis."""

    survivors = RNG.binomial(initial, survive_prob, size=n_iter)

    return pd.DataFrame(
        {
            "survivors": survivors,
            "survivorship": survivors / initial,
            "extinction": 1 - (survivors / initial),
        }
    )


def main() -> None:
    """Run stochastic survivorship simulation."""

    output = simulate_survival(initial=120, survive_prob=0.25, n_iter=1000)

    print(output.describe().round(4).to_string())
    print("5th percentile survivors:", round(np.percentile(output["survivors"], 5), 3))
    print("95th percentile survivors:", round(np.percentile(output["survivors"], 95), 3))


if __name__ == "__main__":
    main()
