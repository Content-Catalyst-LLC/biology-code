"""
Generate a compact reproducible modeling report.

Run from article directory:
    python python/07_generate_report.py
"""

from pathlib import Path
import subprocess
import sys

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
SWEEP_PATH = ARTICLE_DIR / "outputs" / "tables" / "parameter_sweep_summary.csv"
SENSITIVITY_PATH = ARTICLE_DIR / "outputs" / "tables" / "sensitivity_summary.csv"
REPORT_PATH = ARTICLE_DIR / "outputs" / "reports" / "modeling_report.md"


def ensure_inputs() -> None:
    if not SWEEP_PATH.exists():
        subprocess.run([sys.executable, str(ARTICLE_DIR / "python" / "04_parameter_sweep.py")], check=True)
    if not SENSITIVITY_PATH.exists():
        subprocess.run([sys.executable, str(ARTICLE_DIR / "python" / "05_sensitivity_summary.py")], check=True)


def dataframe_to_markdown(df: pd.DataFrame) -> str:
    """Small markdown table helper without requiring optional tabulate dependency."""
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

    sweep = pd.read_csv(SWEEP_PATH).round(5)
    sensitivity = pd.read_csv(SENSITIVITY_PATH).round(5)

    report = [
        "# Python Biological Modeling and Automation Report",
        "",
        "This report was generated from synthetic educational model outputs.",
        "",
        "## Parameter Sweep Summary",
        "",
        dataframe_to_markdown(sweep),
        "",
        "## Sensitivity Summary",
        "",
        dataframe_to_markdown(sensitivity),
        "",
        "## Limitations",
        "",
        "- These examples are scaffolds, not validated biological forecasts.",
        "- Parameter values are synthetic.",
        "- Euler time stepping is used for clarity.",
        "- Real applications require empirical calibration and domain review.",
        "",
    ]

    REPORT_PATH.write_text("\n".join(report))

    print("\n".join(report))
    print(f"Saved: {REPORT_PATH}")


if __name__ == "__main__":
    main()
