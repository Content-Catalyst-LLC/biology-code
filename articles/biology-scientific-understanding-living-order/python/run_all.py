"""
Run all Python workflows for the living-order article repository.

Run:
    python python/run_all.py
"""

from __future__ import annotations

import subprocess
import sys
from pathlib import Path


SCRIPT_DIR = Path(__file__).resolve().parent

SCRIPTS = [
    "living_order_core.py",
    "homeostasis_model.py",
    "growth_models.py",
    "feedback_dynamics.py",
    "network_order.py",
    "resilience_index.py",
    "living_order_condition_scoring.py",
]


def main() -> None:
    """Run each workflow script and stop on failure."""

    for script in SCRIPTS:
        script_path = SCRIPT_DIR / script
        print(f"\n=== Running {script} ===")
        subprocess.run([sys.executable, str(script_path)], check=True)


if __name__ == "__main__":
    main()
