"""
Diffusion and molecular-transport workflow.

Run:
    python python/diffusion_transport.py
"""

from __future__ import annotations

import numpy as np
import pandas as pd

from biomolecule_core import diffusive_flux


def main() -> None:
    """Generate a simple molecular diffusion-gradient table."""

    x = np.linspace(0, 10, 101)
    concentration = 10 - 0.8 * x

    diffusion_coefficient = 2.0
    gradient = -0.8
    flux = diffusive_flux(diffusion_coefficient, gradient)

    df = pd.DataFrame(
        {
            "distance": x,
            "concentration": concentration,
            "diffusion_coefficient": diffusion_coefficient,
            "concentration_gradient": gradient,
            "flux": flux,
        }
    )

    print(df.head(12).round(5).to_string(index=False))
    print(df.tail(12).round(5).to_string(index=False))


if __name__ == "__main__":
    main()
