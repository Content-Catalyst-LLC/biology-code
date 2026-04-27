"""
Generate compact epidemiology modeling report.

Run from article directory:
    python python/08_generate_report.py
"""

from pathlib import Path
import subprocess
import sys

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
SIR_SUMMARY = ARTICLE_DIR / "outputs" / "tables" / "sir_summary.csv"
SEIR_SUMMARY = ARTICLE_DIR / "outputs" / "tables" / "seir_summary.csv"
VALIDATION_PATH = ARTICLE_DIR / "outputs" / "tables" / "validation_metrics.csv"
REPORT_PATH = ARTICLE_DIR / "outputs" / "reports" / "epidemiology_modeling_report.md"


def ensure_inputs() -> None:
    scripts = [
        ("01_sir_model.py", SIR_SUMMARY),
        ("02_seir_model.py", SEIR_SUMMARY),
        ("06_validation_metrics.py", VALIDATION_PATH),
    ]

    for script, path in scripts:
        if not path.exists():
            subprocess.run([sys.executable, str(ARTICLE_DIR / "python" / script)], check=True)


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

    sir = pd.read_csv(SIR_SUMMARY).round(5)
    seir = pd.read_csv(SEIR_SUMMARY).round(5)
    validation = pd.read_csv(VALIDATION_PATH).round(5)

    report = [
        "# Modeling Disease, Epidemiology, and Biological Spread Report",
        "",
        "This report was generated from synthetic educational epidemiological data.",
        "",
        "## SIR Summary",
        "",
        dataframe_to_markdown(sir),
        "",
        "## SEIR Summary",
        "",
        dataframe_to_markdown(seir),
        "",
        "## Forecast Validation Metrics",
        "",
        dataframe_to_markdown(validation),
        "",
        "## Limitations",
        "",
        "- These examples are methodological scaffolds, not operational public-health models.",
        "- Reported cases are not equivalent to true infections.",
        "- Rt proxy calculations are simplified and not validated estimators.",
        "- Real applications require epidemiological review, public-health governance, privacy review, and uncertainty communication.",
        "",
    ]

    REPORT_PATH.write_text("\n".join(report))

    print("\n".join(report))
    print(f"Saved: {REPORT_PATH}")


if __name__ == "__main__":
    main()
