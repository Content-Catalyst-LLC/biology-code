"""
Run all evolutionary medicine Python workflows.

Run from article directory:
    python python/run_all.py
"""

from pathlib import Path
import subprocess
import sys


SCRIPT_DIR = Path(__file__).resolve().parent

SCRIPTS = [
    "01_antimicrobial_resistance_selection.py",
    "02_mismatch_risk_scores.py",
    "03_life_history_tradeoffs.py",
    "04_somatic_evolution.py",
    "05_defense_thresholds.py",
    "06_provenance_manifest.py",
    "07_generate_evolutionary_medicine_report.py",
]


def main() -> None:
    for script in SCRIPTS:
        print(f"\n=== Running {script} ===")
        subprocess.run([sys.executable, str(SCRIPT_DIR / script)], check=True)


if __name__ == "__main__":
    main()
