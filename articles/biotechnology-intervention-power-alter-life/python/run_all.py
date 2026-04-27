"""
Run all biotechnology intervention Python workflows.

Run from article directory:
    python python/run_all.py
"""

from pathlib import Path
import subprocess
import sys


SCRIPT_DIR = Path(__file__).resolve().parent

SCRIPTS = [
    "01_intervention_risk_benefit.py",
    "02_containment_probability.py",
    "03_equity_adjusted_access.py",
    "04_ecological_release_scenarios.py",
    "05_provenance_manifest.py",
    "06_generate_biotechnology_report.py",
]


def main() -> None:
    for script in SCRIPTS:
        print(f"\n=== Running {script} ===")
        subprocess.run([sys.executable, str(SCRIPT_DIR / script)], check=True)


if __name__ == "__main__":
    main()
