"""
Monte Carlo uncertainty screening for substrate-limited microbial growth.

This script samples mu_max, Ks, and S0 to estimate uncertainty in final
abundance under Monod growth.

Run:
    python python/monte_carlo_growth_uncertainty.py
"""

from __future__ import annotations

import numpy as np


RNG = np.random.default_rng(42)


def simulate_final_abundance(
    days: float = 48,
    dt: float = 0.1,
    N0: float = 1e4,
    S0: float = 80.0,
    mu_max: float = 0.7,
    Ks: float = 18.0,
    yield_coeff: float = 1e6,
) -> float:
    """Return final abundance from a Monod growth simulation."""

    time = np.arange(0, days + dt, dt)
    abundance = N0
    substrate = S0

    for _ in time[1:]:
        mu = mu_max * substrate / (Ks + substrate)
        d_abundance = mu * abundance * dt
        d_substrate = -(d_abundance / yield_coeff)

        abundance = max(abundance + d_abundance, 0.0)
        substrate = max(substrate + d_substrate, 0.0)

    return abundance


def main() -> None:
    """Run Monte Carlo uncertainty screen."""

    finals = []

    for _ in range(1000):
        sampled_mu = max(RNG.normal(0.7, 0.08), 0.01)
        sampled_Ks = max(RNG.normal(18.0, 3.0), 0.1)
        sampled_S0 = max(RNG.normal(80.0, 10.0), 1.0)

        finals.append(
            simulate_final_abundance(
                S0=sampled_S0,
                mu_max=sampled_mu,
                Ks=sampled_Ks,
            )
        )

    finals = np.array(finals)

    print(f"Mean final abundance: {finals.mean():.3f}")
    print(f"5th percentile: {np.percentile(finals, 5):.3f}")
    print(f"95th percentile: {np.percentile(finals, 95):.3f}")


if __name__ == "__main__":
    main()
