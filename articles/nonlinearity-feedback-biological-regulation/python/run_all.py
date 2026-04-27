"""
Run all Python nonlinear feedback workflows.

Run:
    python python/run_all.py
"""

from __future__ import annotations

import subprocess
import sys
from pathlib import Path


SCRIPT_DIR = Path(__file__).resolve().parent

SCRIPTS = [
    "nonlinear_feedback_core.py",
    "saturating_response.py",
    "hill_thresholds.py",
    "negative_feedback.py",
    "positive_feedback_switch.py",
    "delayed_feedback.py",
    "logistic_regulation.py",
    "predator_prey_feedback.py",
    "bistability_scaffold.py",
    "sensitivity_analysis.py",
]


def main() -> None:
    for script in SCRIPTS:
        print(f"\n=== Running {script} ===")
        subprocess.run([sys.executable, str(SCRIPT_DIR / script)], check=True)


if __name__ == "__main__":
    main()
