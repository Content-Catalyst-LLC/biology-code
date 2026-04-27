"""
Run all Python statistics and measurement workflows.

Run:
    python python/run_all.py
"""

from __future__ import annotations

import subprocess
import sys
from pathlib import Path


SCRIPT_DIR = Path(__file__).resolve().parent

SCRIPTS = [
    "statistics_measurement_core.py",
    "descriptive_uncertainty.py",
    "uncertainty_budget.py",
    "calibration_curve.py",
    "measurement_error_simulation.py",
    "variance_components.py",
    "bootstrap_intervals.py",
    "assay_quality_control.py",
    "error_propagation.py",
    "mixed_effects_scaffold.py",
]


def main() -> None:
    for script in SCRIPTS:
        print(f"\n=== Running {script} ===")
        subprocess.run([sys.executable, str(SCRIPT_DIR / script)], check=True)


if __name__ == "__main__":
    main()
