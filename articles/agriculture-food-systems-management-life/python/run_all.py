"""
Run all agriculture and food-system Python workflows.

Run from article directory:
    python python/run_all.py
"""

from pathlib import Path
import subprocess
import sys


SCRIPT_DIR = Path(__file__).resolve().parent

SCRIPTS = [
    "01_food_system_indicators.py",
    "02_biodiversity_resilience.py",
    "03_soil_carbon_change.py",
    "04_diet_diversity.py",
    "05_food_loss_accounting.py",
    "06_provenance_manifest.py",
    "07_generate_food_system_report.py",
]


def main() -> None:
    for script in SCRIPTS:
        print(f"\n=== Running {script} ===")
        subprocess.run([sys.executable, str(SCRIPT_DIR / script)], check=True)


if __name__ == "__main__":
    main()
