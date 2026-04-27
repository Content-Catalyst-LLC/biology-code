"""
Run all synthetic biology Python workflows.

Run from article directory:
    python python/run_all.py
"""

from pathlib import Path
import subprocess
import sys


SCRIPT_DIR = Path(__file__).resolve().parent

SCRIPTS = [
    "01_design_build_test_learn.py",
    "02_biosensor_signal_to_noise.py",
    "03_host_burden.py",
    "04_metabolic_yield.py",
    "05_genetic_circuit_dynamics.py",
    "06_provenance_manifest.py",
    "07_generate_synthetic_biology_report.py",
]


def main() -> None:
    for script in SCRIPTS:
        print(f"\n=== Running {script} ===")
        subprocess.run([sys.executable, str(SCRIPT_DIR / script)], check=True)


if __name__ == "__main__":
    main()
