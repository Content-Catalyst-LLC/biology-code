"""
Run all Python mathematical-biology workflows.

Run:
    python python/run_all.py
"""

from __future__ import annotations

import subprocess
import sys
from pathlib import Path


SCRIPT_DIR = Path(__file__).resolve().parent

SCRIPTS = [
    "math_biology_core.py",
    "population_dynamics.py",
    "predator_prey.py",
    "epidemic_models.py",
    "enzyme_kinetics.py",
    "reaction_diffusion.py",
    "stochastic_birth_death.py",
    "network_analysis.py",
    "sensitivity_analysis.py",
    "optimization_scaffold.py",
]


def main() -> None:
    for script in SCRIPTS:
        print(f"\n=== Running {script} ===")
        subprocess.run([sys.executable, str(SCRIPT_DIR / script)], check=True)


if __name__ == "__main__":
    main()
