"""
Run all Python differential-equation workflows.

Run:
    python python/run_all.py
"""

from __future__ import annotations

import subprocess
import sys
from pathlib import Path


SCRIPT_DIR = Path(__file__).resolve().parent

SCRIPTS = [
    "differential_equations_core.py",
    "logistic_growth.py",
    "predator_prey.py",
    "sir_epidemic.py",
    "homeostasis.py",
    "pharmacokinetics.py",
    "chemostat.py",
    "reaction_diffusion.py",
    "sensitivity_analysis.py",
]


def main() -> None:
    for script in SCRIPTS:
        print(f"\n=== Running {script} ===")
        subprocess.run([sys.executable, str(SCRIPT_DIR / script)], check=True)


if __name__ == "__main__":
    main()
