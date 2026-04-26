"""
Run all Python workflows for the biomolecules article repository.

Run:
    python python/run_all.py
"""

from __future__ import annotations

import subprocess
import sys
from pathlib import Path


SCRIPT_DIR = Path(__file__).resolve().parent

SCRIPTS = [
    "biomolecule_core.py",
    "composition_analysis.py",
    "sequence_features.py",
    "enzyme_kinetics.py",
    "ligand_binding.py",
    "diffusion_transport.py",
    "polymer_mass_balance.py",
    "biomolecular_condition_scoring.py",
]


def main() -> None:
    """Run each workflow script and stop on failure."""

    for script in SCRIPTS:
        script_path = SCRIPT_DIR / script
        print(f"\n=== Running {script} ===")
        subprocess.run([sys.executable, str(script_path)], check=True)


if __name__ == "__main__":
    main()
