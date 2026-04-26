"""
Run all Python workflows for the cell-architecture article repository.

Run:
    python python/run_all.py
"""

from __future__ import annotations

import subprocess
import sys
from pathlib import Path


SCRIPT_DIR = Path(__file__).resolve().parent

SCRIPTS = [
    "cell_architecture_core.py",
    "membrane_transport.py",
    "compartment_flux_model.py",
    "organelle_morphometry.py",
    "organelle_network.py",
    "cellular_architecture_condition_scoring.py",
]


def main() -> None:
    """Run each workflow script and stop on failure."""

    for script in SCRIPTS:
        script_path = SCRIPT_DIR / script
        print(f"\n=== Running {script} ===")
        subprocess.run([sys.executable, str(script_path)], check=True)


if __name__ == "__main__":
    main()
