"""
Run all genomics sequence-analysis workflows.

Run from article directory:
    python python/run_all.py
"""

from __future__ import annotations

import subprocess
import sys
from pathlib import Path


SCRIPT_DIR = Path(__file__).resolve().parent

SCRIPTS = [
    "01_sequence_summary.py",
    "02_kmer_counting.py",
    "03_orf_detection.py",
    "04_translation_scaffold.py",
    "05_fastq_quality_summary.py",
    "06_variant_validation.py",
    "07_metadata_validation.py",
    "08_workflow_manifest.py",
    "09_generate_report.py",
]


def main() -> None:
    for script in SCRIPTS:
        print(f"\n=== Running {script} ===")
        subprocess.run([sys.executable, str(SCRIPT_DIR / script)], check=True)


if __name__ == "__main__":
    main()
