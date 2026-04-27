"""
Run all Python data, measurement, and reproducibility workflows.

Run:
    python python/run_all.py
"""

from __future__ import annotations

import subprocess
import sys
from pathlib import Path


SCRIPT_DIR = Path(__file__).resolve().parent

SCRIPTS = [
    "reproducibility_core.py",
    "measurement_quality_summary.py",
    "schema_validation.py",
    "uncertainty_budget.py",
    "provenance_manifest.py",
    "checksum_manifest.py",
    "qc_flag_summary.py",
    "reproducibility_report.py",
    "workflow_audit.py",
]


def main() -> None:
    for script in SCRIPTS:
        print(f"\n=== Running {script} ===")
        subprocess.run([sys.executable, str(SCRIPT_DIR / script)], check=True)


if __name__ == "__main__":
    main()
