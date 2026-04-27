"""
Run all biology ethics Python workflows.

Run from article directory:
    python python/run_all.py
"""

from pathlib import Path
import subprocess
import sys


SCRIPT_DIR = Path(__file__).resolve().parent

SCRIPTS = [
    "01_ethical_review_scores.py",
    "02_consent_completeness.py",
    "03_justice_adjusted_benefit.py",
    "04_ecological_risk.py",
    "05_governance_flags.py",
    "06_provenance_manifest.py",
    "07_generate_biology_ethics_report.py",
]


def main() -> None:
    for script in SCRIPTS:
        print(f"\n=== Running {script} ===")
        subprocess.run([sys.executable, str(SCRIPT_DIR / script)], check=True)


if __name__ == "__main__":
    main()
