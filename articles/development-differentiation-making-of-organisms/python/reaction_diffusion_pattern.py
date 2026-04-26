"""
One-dimensional reaction-diffusion developmental patterning scaffold.

Run:
    python python/reaction_diffusion_pattern.py
"""

from __future__ import annotations

import numpy as np
import pandas as pd


def simulate_reaction_diffusion(
    n: int = 120,
    steps: int = 1500,
    Du: float = 0.001,
    Dv: float = 0.01,
    a: float = 0.04,
    b: float = 0.065,
    dt: float = 1.0,
    seed: int = 42,
) -> pd.DataFrame:
    """Simulate a simple one-dimensional activator-inhibitor pattern."""

    rng = np.random.default_rng(seed)
    u = np.ones(n) + 0.01 * rng.normal(size=n)
    v = np.zeros(n) + 0.01 * rng.normal(size=n)

    def laplacian(arr: np.ndarray) -> np.ndarray:
        left = np.roll(arr, 1)
        right = np.roll(arr, -1)
        return left - 2 * arr + right

    for _ in range(steps):
        Lu = laplacian(u)
        Lv = laplacian(v)

        du = Du * Lu + a - u + u * u * v
        dv = Dv * Lv + b - u * u * v

        u += du * dt
        v += dv * dt

    return pd.DataFrame(
        {
            "position": np.arange(n),
            "u": u,
            "v": v,
        }
    )


def main() -> None:
    """Run reaction-diffusion patterning scaffold."""

    pattern_df = simulate_reaction_diffusion()

    print(pattern_df.head(20).round(4).to_string(index=False))
    print(pattern_df.describe().round(4).to_string())


if __name__ == "__main__":
    main()
