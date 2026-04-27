"""
Run all computational ecology workflows.

Run from article directory:
    python python/run_all.py
"""

from __future__ import annotations

import subprocess
import sys
from pathlib import Path


SCRIPT_DIR = Path(__file__).resolve().parent

SCRIPTS = [
    "01_habitat_suitability.py",
    "02_patch_occupancy.py",
    "03_environmental_stress_scenarios.py",
    "04_runoff_scaffold.py",
    "05_validation_metrics.py",
    "06_workflow_manifest.py",
    "07_generate_report.py",
]


def main() -> None:
    for script in SCRIPTS:
        print(f"\n=== Running {script} ===")
        subprocess.run([sys.executable, str(SCRIPT_DIR / script)], check=True)


if __name__ == "__main__":
    main()
