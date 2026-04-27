"""
Run all systems-biology workflows.

Run from article directory:
    python python/run_all.py
"""

from __future__ import annotations

import subprocess
import sys
from pathlib import Path


SCRIPT_DIR = Path(__file__).resolve().parent

SCRIPTS = [
    "01_network_summary.py",
    "02_signal_propagation.py",
    "03_feedback_dynamics.py",
    "04_pathway_activity.py",
    "05_flux_balance_scaffold.py",
    "06_omics_integration.py",
    "07_validation_metrics.py",
    "08_workflow_manifest.py",
    "09_generate_report.py",
]


def main() -> None:
    for script in SCRIPTS:
        print(f"\n=== Running {script} ===")
        subprocess.run([sys.executable, str(SCRIPT_DIR / script)], check=True)


if __name__ == "__main__":
    main()
