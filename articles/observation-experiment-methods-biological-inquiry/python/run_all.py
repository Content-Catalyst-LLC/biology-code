"""
Run all Python workflows.

Run:
    python python/run_all.py
"""

from __future__ import annotations

import subprocess
import sys
from pathlib import Path


SCRIPT_DIR = Path(__file__).resolve().parent

SCRIPTS = [
    "biological_methods_core.py",
    "growth_models.py",
    "assay_validation.py",
    "sequence_matching.py",
    "imaging_summary.py",
    "experimental_signal_scoring.py",
]


def main() -> None:
    for script in SCRIPTS:
        print(f"\n=== Running {script} ===")
        subprocess.run([sys.executable, str(SCRIPT_DIR / script)], check=True)


if __name__ == "__main__":
    main()
