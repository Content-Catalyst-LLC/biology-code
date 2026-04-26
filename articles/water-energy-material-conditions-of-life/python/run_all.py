"""
Run all Python workflows for the water-energy article repository.

Run:
    python python/run_all.py
"""

from __future__ import annotations

import subprocess
import sys
from pathlib import Path


SCRIPT_DIR = Path(__file__).resolve().parent

SCRIPTS = [
    "water_energy_core.py",
    "osmotic_pressure.py",
    "water_potential.py",
    "homeostatic_setpoint.py",
    "growth_energy_model.py",
    "oxygen_limitation.py",
    "energy_budget_allocation.py",
    "material_condition_scoring.py",
]


def main() -> None:
    """Run each workflow script and stop on failure."""

    for script in SCRIPTS:
        script_path = SCRIPT_DIR / script
        print(f"\n=== Running {script} ===")
        subprocess.run([sys.executable, str(script_path)], check=True)


if __name__ == "__main__":
    main()
