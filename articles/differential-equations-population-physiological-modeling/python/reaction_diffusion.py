"""
Reaction-diffusion scaffold using a one-dimensional finite-difference grid.

Run:
    python python/reaction_diffusion.py
"""

import numpy as np
import pandas as pd


def laplacian_1d(values: np.ndarray, dx: float) -> np.ndarray:
    padded = np.pad(values, pad_width=1, mode="edge")
    return (padded[:-2] - 2 * padded[1:-1] + padded[2:]) / (dx * dx)


def simulate_reaction_diffusion(n_grid: int = 80, steps: int = 800, dt: float = 0.001, dx: float = 1.0) -> pd.DataFrame:
    D_u = 0.08
    D_v = 0.20
    a = 0.08
    b = 0.06

    x = np.arange(n_grid)
    u = 0.5 + 0.02 * np.sin(2 * np.pi * x / n_grid)
    v = 0.25 + 0.02 * np.cos(2 * np.pi * x / n_grid)

    for _ in range(steps):
        reaction_u = u * (1 - u) - (u * v) / (u + a)
        reaction_v = b * (u - v)

        u = np.maximum(u + dt * (D_u * laplacian_1d(u, dx) + reaction_u), 0)
        v = np.maximum(v + dt * (D_v * laplacian_1d(v, dx) + reaction_v), 0)

    return pd.DataFrame({"position": x, "activator_u": u, "inhibitor_v": v})


def main() -> None:
    result = simulate_reaction_diffusion()
    summary = pd.DataFrame(
        {
            "mean_activator": [result["activator_u"].mean()],
            "mean_inhibitor": [result["inhibitor_v"].mean()],
            "range_activator": [result["activator_u"].max() - result["activator_u"].min()],
            "range_inhibitor": [result["inhibitor_v"].max() - result["inhibitor_v"].min()],
        }
    )
    print(summary.round(6).to_string(index=False))


if __name__ == "__main__":
    main()
