"""
Run all epidemiology modeling workflows.

Run from article directory:
    python python/run_all.py
"""

from __future__ import annotations

import subprocess
import sys
from pathlib import Path


SCRIPT_DIR = Path(__file__).resolve().parent

SCRIPTS = [
    "01_sir_model.py",
    "02_seir_model.py",
    "03_rt_proxy.py",
    "04_branching_process.py",
    "05_reporting_delay_adjustment.py",
    "06_validation_metrics.py",
    "07_workflow_manifest.py",
    "08_generate_report.py",
]


def main() -> None:
    for script in SCRIPTS:
        print(f"\n=== Running {script} ===")
        subprocess.run([sys.executable, str(SCRIPT_DIR / script)], check=True)


if __name__ == "__main__":
    main()
