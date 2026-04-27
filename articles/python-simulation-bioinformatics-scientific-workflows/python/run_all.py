"""
Run all Python workflows.

Run from article directory:
    python python/run_all.py
"""

from __future__ import annotations

import subprocess
import sys
from pathlib import Path


SCRIPT_DIR = Path(__file__).resolve().parent

SCRIPTS = [
    "01_logistic_growth_simulation.py",
    "02_stochastic_population_simulation.py",
    "03_sequence_summary.py",
    "04_kmer_counting.py",
    "05_metadata_validation.py",
    "06_workflow_manifest.py",
]


def main() -> None:
    for script in SCRIPTS:
        print(f"\n=== Running {script} ===")
        subprocess.run([sys.executable, str(SCRIPT_DIR / script)], check=True)


if __name__ == "__main__":
    main()
