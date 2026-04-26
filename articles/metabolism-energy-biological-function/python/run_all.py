"""
Run all Python workflows for the metabolism article repository.

Run:
    python python/run_all.py
"""

from __future__ import annotations

import subprocess
import sys
from pathlib import Path


SCRIPT_DIR = Path(__file__).resolve().parent

SCRIPTS = [
    "metabolism_core.py",
    "growth_models.py",
    "yield_allocation.py",
    "monod_substrate_limitation.py",
    "respirometry_summary.py",
    "toy_flux_balance.py",
    "metabolic_condition_scoring.py",
]


def main() -> None:
    """Run each workflow script and stop on failure."""

    for script in SCRIPTS:
        script_path = SCRIPT_DIR / script
        print(f"\n=== Running {script} ===")
        subprocess.run([sys.executable, str(script_path)], check=True)


if __name__ == "__main__":
    main()
