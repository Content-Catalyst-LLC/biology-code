"""
Run all Python biostatistics and experimental-design workflows.

Run:
    python python/run_all.py
"""

from __future__ import annotations

import subprocess
import sys
from pathlib import Path


SCRIPT_DIR = Path(__file__).resolve().parent

SCRIPTS = [
    "experimental_design_core.py",
    "randomized_allocation.py",
    "two_group_inference.py",
    "power_simulation.py",
    "factorial_design.py",
    "blocked_design_summary.py",
    "bootstrap_uncertainty.py",
    "permutation_test.py",
    "mixed_effects_scaffold.py",
    "assay_design_simulation.py",
]


def main() -> None:
    for script in SCRIPTS:
        print(f"\n=== Running {script} ===")
        subprocess.run([sys.executable, str(SCRIPT_DIR / script)], check=True)


if __name__ == "__main__":
    main()
