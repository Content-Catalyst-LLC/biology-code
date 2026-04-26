"""
Run all Python workflows for the life-definition article repository.

Run:
    python python/run_all.py
"""

from __future__ import annotations

import subprocess
import sys
from pathlib import Path


SCRIPT_DIR = Path(__file__).resolve().parent

SCRIPTS = [
    "definition_core.py",
    "viability_decay.py",
    "dormancy_model.py",
    "host_virus_dynamics.py",
    "survival_curve.py",
    "borderline_case_scoring.py",
]


def main() -> None:
    """Run each workflow script and stop on failure."""

    for script in SCRIPTS:
        script_path = SCRIPT_DIR / script
        print(f"\n=== Running {script} ===")
        subprocess.run([sys.executable, str(script_path)], check=True)


if __name__ == "__main__":
    main()
