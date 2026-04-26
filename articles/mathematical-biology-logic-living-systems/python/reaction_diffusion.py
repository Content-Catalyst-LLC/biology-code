"""
Reaction-diffusion scaffold using a one-dimensional finite-difference grid.

Run:
    python python/reaction_diffusion.py
"""

import numpy as np
import pandas as pd


def laplacian_1d(values: np.ndarray, dx: float) -> np.ndarray:
    """Calculate a one-dimensional Laplacian with no-flux boundary approximation."""
    padded = np.pad(values, pad_width=1, mode="edge")
    return (padded[:-2] - 2 * padded[1:-1] + padded[2:]) / (dx * dx)


def simulate_reaction_diffusion(n_grid: int = 80, steps: int = 800, dt: float = 0.001, dx: float = 1.0) -> pd.DataFrame:
    """Simulate a small activator-inhibitor reaction-diffusion scaffold."""
    du = 0.08
    dv = 0.20
    a = 0.08
    b = 0.06

    x = np.arange(n_grid)
    u = 0.5 + 0.02 * np.sin(2 * np.pi * x / n_grid)
    v = 0.25 + 0.02 * np.cos(2 * np.pi * x / n_grid)

    for _ in range(steps):
        reaction_u = u * (1 - u) - (u * v) / (u + a)
        reaction_v = b * (u - v)

        u = np.maximum(u + dt * (du * laplacian_1d(u, dx) + reaction_u), 0)
        v = np.maximum(v + dt * (dv * laplacian_1d(v, dx) + reaction_v), 0)

    return pd.DataFrame({"position": x, "activator_u": u, "inhibitor_v": v})


def main() -> None:
    result = simulate_reaction_diffusion()
    print(result.head(12).round(5).to_string(index=False))
    print(result.tail(12).round(5).to_string(index=False))


if __name__ == "__main__":
    main()
