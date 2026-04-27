"""
Generate a reproducibility report for the biological notebook workflow.

Run from article directory:
    python python/04_generate_reproducibility_report.py
"""

from pathlib import Path
import subprocess
import sys

import pandas as pd

from notebook_reproducibility_core import dataframe_to_markdown


ARTICLE_DIR = Path(__file__).resolve().parents[1]
REPORT_PATH = ARTICLE_DIR / "outputs" / "reports" / "reproducibility_report.md"

REQUIRED_OUTPUTS = [
    ("01_validate_sample_metadata.py", ARTICLE_DIR / "outputs" / "tables" / "metadata_validation.csv"),
    ("01_validate_sample_metadata.py", ARTICLE_DIR / "outputs" / "tables" / "group_summary.csv"),
    ("02_create_provenance_manifest.py", ARTICLE_DIR / "outputs" / "manifests" / "provenance_manifest.csv"),
    ("03_notebook_execution_check.py", ARTICLE_DIR / "outputs" / "tables" / "notebook_execution_check.csv"),
]


def ensure_outputs() -> None:
    for script, path in REQUIRED_OUTPUTS:
        if not path.exists():
            subprocess.run([sys.executable, str(ARTICLE_DIR / "python" / script)], check=True)


def main() -> None:
    REPORT_PATH.parent.mkdir(parents=True, exist_ok=True)
    ensure_outputs()

    validation = pd.read_csv(ARTICLE_DIR / "outputs" / "tables" / "metadata_validation.csv")
    group_summary = pd.read_csv(ARTICLE_DIR / "outputs" / "tables" / "group_summary.csv").round(5)
    provenance = pd.read_csv(ARTICLE_DIR / "outputs" / "manifests" / "provenance_manifest.csv")
    execution = pd.read_csv(ARTICLE_DIR / "outputs" / "tables" / "notebook_execution_check.csv")

    report = [
        "# Computational Notebooks and Reproducible Biological Research Report",
        "",
        "This report was generated from synthetic educational biological notebook data.",
        "",
        "## Metadata Validation",
        "",
        dataframe_to_markdown(validation),
        "",
        "## Group Summary",
        "",
        dataframe_to_markdown(group_summary),
        "",
        "## Provenance Manifest",
        "",
        dataframe_to_markdown(provenance[["artifact", "artifact_type", "relative_path", "sha256"]]),
        "",
        "## Notebook Execution Check",
        "",
        dataframe_to_markdown(execution[["notebook_name", "kernel", "clean_run", "failed_cells", "executed_cells", "status"]]),
        "",
        "## Interpretation Warning",
        "",
        "A notebook that executes successfully is not automatically biologically valid. Reproducibility supports inspection, but scientific claims still require domain expertise, validation, and appropriate evidence.",
        "",
    ]

    REPORT_PATH.write_text("\n".join(report))

    print("\n".join(report))
    print(f"Saved: {REPORT_PATH}")


if __name__ == "__main__":
    main()
