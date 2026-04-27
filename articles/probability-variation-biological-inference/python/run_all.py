"""
Run all Python probability and biological inference workflows.

Run:
    python python/run_all.py
"""

from __future__ import annotations

import subprocess
import sys
from pathlib import Path


SCRIPT_DIR = Path(__file__).resolve().parent

SCRIPTS = [
    "probability_core.py",
    "binomial_inference.py",
    "bayesian_update.py",
    "bootstrap_uncertainty.py",
    "permutation_test.py",
    "power_simulation.py",
    "likelihood_comparison.py",
    "false_discovery_scaffold.py",
    "stochastic_sampling.py",
]


def main() -> None:
    for script in SCRIPTS:
        print(f"\n=== Running {script} ===")
        subprocess.run([sys.executable, str(SCRIPT_DIR / script)], check=True)


if __name__ == "__main__":
    main()
