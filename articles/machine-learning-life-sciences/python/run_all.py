"""
Run all Python workflows for Machine Learning in the Life Sciences.

Run from the article directory:
    python python/run_all.py
"""

from pathlib import Path
import subprocess
import sys


SCRIPT_DIR = Path(__file__).resolve().parent

SCRIPTS = [
    "01_train_biomarker_classifier.py",
    "02_external_validation.py",
    "03_feature_importance_report.py",
    "04_model_provenance_manifest.py",
    "05_generate_ml_report.py",
]


def main() -> None:
    for script in SCRIPTS:
        print(f"\n=== Running {script} ===")
        subprocess.run([sys.executable, str(SCRIPT_DIR / script)], check=True)


if __name__ == "__main__":
    main()
