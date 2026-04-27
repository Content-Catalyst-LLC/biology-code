"""
Generate compact genomics sequence-analysis report.

Run from article directory:
    python python/09_generate_report.py
"""

from pathlib import Path
import subprocess
import sys

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
SEQUENCE_SUMMARY = ARTICLE_DIR / "outputs" / "tables" / "sequence_summary.csv"
VARIANT_VALIDATION = ARTICLE_DIR / "outputs" / "tables" / "variant_validation.csv"
REPORT_PATH = ARTICLE_DIR / "outputs" / "reports" / "genomics_sequence_report.md"


def ensure_inputs() -> None:
    if not SEQUENCE_SUMMARY.exists():
        subprocess.run([sys.executable, str(ARTICLE_DIR / "python" / "01_sequence_summary.py")], check=True)
    if not VARIANT_VALIDATION.exists():
        subprocess.run([sys.executable, str(ARTICLE_DIR / "python" / "06_variant_validation.py")], check=True)


def dataframe_to_markdown(df: pd.DataFrame) -> str:
    headers = list(df.columns)
    lines = [
        "| " + " | ".join(headers) + " |",
        "| " + " | ".join(["---"] * len(headers)) + " |",
    ]

    for _, row in df.iterrows():
        lines.append("| " + " | ".join(str(row[col]) for col in headers) + " |")

    return "\n".join(lines)


def main() -> None:
    REPORT_PATH.parent.mkdir(parents=True, exist_ok=True)
    ensure_inputs()

    sequence_summary = pd.read_csv(SEQUENCE_SUMMARY).round(5)
    variant_validation = pd.read_csv(VARIANT_VALIDATION).round(5)

    report = [
        "# Genomics, Sequence Analysis, and Biological Data Report",
        "",
        "This report was generated from synthetic educational genomics data.",
        "",
        "## Sequence Summary",
        "",
        dataframe_to_markdown(sequence_summary),
        "",
        "## Variant Validation",
        "",
        dataframe_to_markdown(variant_validation),
        "",
        "## Limitations",
        "",
        "- These examples are educational scaffolds, not production genomics workflows.",
        "- ORF detection is simplified and forward-strand only.",
        "- Variant validation is structural and does not imply biological or clinical interpretation.",
        "- Real analysis requires reference versioning, quality-control review, and domain-specific validation.",
        "",
    ]

    REPORT_PATH.write_text("\n".join(report))

    print("\n".join(report))
    print(f"Saved: {REPORT_PATH}")


if __name__ == "__main__":
    main()
