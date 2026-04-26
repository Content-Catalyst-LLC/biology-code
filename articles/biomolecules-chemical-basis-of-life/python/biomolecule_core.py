"""
Core biomolecular models and validation utilities.

Run:
    python python/biomolecule_core.py
"""

from __future__ import annotations

from collections import Counter
from dataclasses import dataclass
import math
from typing import Iterable

import numpy as np


DNA_ALPHABET = set("ATGC")
PROTEIN_ALPHABET = set("ACDEFGHIKLMNPQRSTVWY")


@dataclass(frozen=True)
class SequenceFeatures:
    """Container for sequence feature outputs."""

    sequence_id: str
    sequence_type: str
    length: int
    gc_content: float | None
    hydrophobic_fraction: float | None
    charged_fraction: float | None


def validate_finite(values: Iterable[float], label: str) -> None:
    """Raise ValueError if any value is non-finite."""

    arr = np.asarray(list(values), dtype=float)
    if np.any(~np.isfinite(arr)):
        raise ValueError(f"{label} contains non-finite values.")


def michaelis_menten(substrate: np.ndarray, vmax: float, km: float) -> np.ndarray:
    """Calculate Michaelis-Menten reaction velocity."""

    if vmax < 0:
        raise ValueError("vmax must be non-negative.")
    if km <= 0:
        raise ValueError("km must be positive.")
    if np.any(substrate < 0):
        raise ValueError("substrate must be non-negative.")

    return (vmax * substrate) / (km + substrate)


def ligand_fraction_bound(ligand: np.ndarray, kd: float) -> np.ndarray:
    """Calculate one-site ligand-binding fractional occupancy."""

    if kd <= 0:
        raise ValueError("kd must be positive.")
    if np.any(ligand < 0):
        raise ValueError("ligand concentration must be non-negative.")

    return ligand / (kd + ligand)


def diffusive_flux(diffusion_coefficient: float, concentration_gradient: float) -> float:
    """Calculate Fick-style diffusive flux."""

    if diffusion_coefficient < 0:
        raise ValueError("diffusion_coefficient must be non-negative.")

    return -diffusion_coefficient * concentration_gradient


def gc_content(sequence: str) -> float:
    """Calculate GC content for a DNA sequence."""

    sequence = sequence.upper()
    invalid = set(sequence) - DNA_ALPHABET

    if invalid:
        raise ValueError(f"DNA sequence contains invalid characters: {sorted(invalid)}")
    if not sequence:
        raise ValueError("DNA sequence must not be empty.")

    counts = Counter(sequence)
    return (counts.get("G", 0) + counts.get("C", 0)) / len(sequence)


def protein_sequence_features(sequence: str) -> dict[str, float | int]:
    """Calculate basic protein sequence features."""

    sequence = sequence.upper()
    invalid = set(sequence) - PROTEIN_ALPHABET

    if invalid:
        raise ValueError(f"Protein sequence contains invalid characters: {sorted(invalid)}")
    if not sequence:
        raise ValueError("Protein sequence must not be empty.")

    counts = Counter(sequence)
    hydrophobic = set("AILMFWYV")
    charged = set("DEKRH")

    hydrophobic_fraction = sum(counts.get(residue, 0) for residue in hydrophobic) / len(sequence)
    charged_fraction = sum(counts.get(residue, 0) for residue in charged) / len(sequence)

    return {
        "length": len(sequence),
        "hydrophobic_fraction": hydrophobic_fraction,
        "charged_fraction": charged_fraction,
    }


def polymer_mass_estimate(monomer_count: int, mean_monomer_mass_da: float, water_loss_per_bond_da: float) -> float:
    """Estimate polymer mass using a simple condensation mass-balance scaffold."""

    if monomer_count <= 0:
        raise ValueError("monomer_count must be positive.")
    if mean_monomer_mass_da < 0:
        raise ValueError("mean_monomer_mass_da must be non-negative.")
    if water_loss_per_bond_da < 0:
        raise ValueError("water_loss_per_bond_da must be non-negative.")

    n_bonds = max(monomer_count - 1, 0)
    return monomer_count * mean_monomer_mass_da - n_bonds * water_loss_per_bond_da


def main() -> None:
    """Run smoke-test outputs."""

    substrate = np.array([0.5, 1, 2, 5, 10, 20], dtype=float)
    print(michaelis_menten(substrate, 100.0, 3.0))

    ligand = np.array([0.5, 4, 8, 25], dtype=float)
    print(ligand_fraction_bound(ligand, 8.0))

    print("gc_content=", round(gc_content("ATGCGCGTATTAACCGGTTAGCGCGATATCGCGTA"), 6))
    print(protein_sequence_features("MKWVTFISLLFLFSSAYSRGVFRRDTHKSEIAHRFKDLGE"))
    print("polymer_mass=", round(polymer_mass_estimate(12, 110.0, 18.015), 6))


if __name__ == "__main__":
    main()
