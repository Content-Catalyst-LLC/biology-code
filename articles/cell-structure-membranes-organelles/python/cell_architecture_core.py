"""
Core cell-architecture models and validation utilities.

Run:
    python python/cell_architecture_core.py
"""

from __future__ import annotations

from dataclasses import dataclass
import math
from typing import Iterable

import numpy as np


@dataclass(frozen=True)
class SphericalCell:
    """Geometric properties of a spherical cell."""

    radius_um: float
    surface_area_um2: float
    volume_um3: float
    surface_area_to_volume: float


def validate_finite(values: Iterable[float], label: str) -> None:
    """Raise ValueError if any value is non-finite."""

    arr = np.asarray(list(values), dtype=float)
    if np.any(~np.isfinite(arr)):
        raise ValueError(f"{label} contains non-finite values.")


def spherical_cell(radius_um: float) -> SphericalCell:
    """Calculate spherical cell surface area, volume, and SA:V ratio."""

    if radius_um <= 0:
        raise ValueError("radius_um must be positive.")

    surface_area = 4 * math.pi * radius_um**2
    volume = (4 / 3) * math.pi * radius_um**3

    return SphericalCell(
        radius_um=radius_um,
        surface_area_um2=surface_area,
        volume_um3=volume,
        surface_area_to_volume=surface_area / volume,
    )


def permeability_flux(permeability_um_s: float, external_concentration: float, internal_concentration: float) -> float:
    """Calculate permeability-limited flux J = P(Cout - Cin)."""

    if permeability_um_s < 0:
        raise ValueError("permeability_um_s must be non-negative.")

    validate_finite([external_concentration, internal_concentration], "concentrations")

    return permeability_um_s * (external_concentration - internal_concentration)


def diffusive_flux(diffusion_coefficient: float, concentration_gradient: float) -> float:
    """Calculate Fick-style diffusive flux J = -D dC/dx."""

    if diffusion_coefficient < 0:
        raise ValueError("diffusion_coefficient must be non-negative.")

    return -diffusion_coefficient * concentration_gradient


def organelle_fraction(organelle_area_um2: float, cell_area_um2: float) -> float:
    """Calculate organelle area fraction."""

    if cell_area_um2 <= 0:
        raise ValueError("cell_area_um2 must be positive.")
    if organelle_area_um2 < 0:
        raise ValueError("organelle_area_um2 must be non-negative.")

    return organelle_area_um2 / cell_area_um2


def organelle_density(count: float, cell_area_um2: float) -> float:
    """Calculate organelle density per unit cell area."""

    if cell_area_um2 <= 0:
        raise ValueError("cell_area_um2 must be positive.")
    if count < 0:
        raise ValueError("count must be non-negative.")

    return count / cell_area_um2


def main() -> None:
    """Run simple smoke-test outputs."""

    cell = spherical_cell(5.0)
    print(cell)

    print("permeability_flux=", round(permeability_flux(0.05, 10.0, 3.0), 6))
    print("diffusive_flux=", round(diffusive_flux(2.0, -0.8), 6))
    print("organelle_fraction=", round(organelle_fraction(62.0, 420.0), 6))
    print("organelle_density=", round(organelle_density(18.0, 420.0), 6))


if __name__ == "__main__":
    main()
