"""
Run all microscopy image-analysis workflows.

Run from article directory:
    python python/run_all.py
"""

from __future__ import annotations

import subprocess
import sys
from pathlib import Path


SCRIPT_DIR = Path(__file__).resolve().parent

SCRIPTS = [
    "01_generate_synthetic_microscopy.py",
    "02_threshold_segmentation.py",
    "03_object_feature_extraction.py",
    "04_segmentation_validation.py",
    "05_colocalization_summary.py",
    "06_tracking_summary.py",
    "07_workflow_manifest.py",
    "08_generate_report.py",
]


def main() -> None:
    for script in SCRIPTS:
        print(f"\n=== Running {script} ===")
        subprocess.run([sys.executable, str(SCRIPT_DIR / script)], check=True)


if __name__ == "__main__":
    main()
