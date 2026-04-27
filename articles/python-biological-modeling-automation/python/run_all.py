"""
Run all Python biological modeling and automation workflows.

Run from article directory:
    python python/run_all.py
"""

from __future__ import annotations

import subprocess
import sys
from pathlib import Path


SCRIPT_DIR = Path(__file__).resolve().parent

SCRIPTS = [
    "01_validate_parameters.py",
    "02_logistic_growth_model.py",
    "03_two_compartment_model.py",
    "04_parameter_sweep.py",
    "05_sensitivity_summary.py",
    "06_workflow_manifest.py",
    "07_generate_report.py",
]


def main() -> None:
    for script in SCRIPTS:
        print(f"\n=== Running {script} ===")
        subprocess.run([sys.executable, str(SCRIPT_DIR / script)], check=True)


if __name__ == "__main__":
    main()
