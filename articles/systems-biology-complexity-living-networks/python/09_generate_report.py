"""
Generate compact systems-biology report.

Run from article directory:
    python python/09_generate_report.py
"""

from pathlib import Path
import subprocess
import sys

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
NETWORK_PATH = ARTICLE_DIR / "outputs" / "tables" / "network_summary.csv"
PATHWAY_PATH = ARTICLE_DIR / "outputs" / "tables" / "pathway_activity.csv"
VALIDATION_PATH = ARTICLE_DIR / "outputs" / "tables" / "validation_metrics.csv"
REPORT_PATH = ARTICLE_DIR / "outputs" / "reports" / "systems_biology_report.md"


def ensure_inputs() -> None:
    scripts = [
        ("01_network_summary.py", NETWORK_PATH),
        ("04_pathway_activity.py", PATHWAY_PATH),
        ("07_validation_metrics.py", VALIDATION_PATH),
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

    network = pd.read_csv(NETWORK_PATH).round(5)
    pathway = pd.read_csv(PATHWAY_PATH).round(5)
    validation = pd.read_csv(VALIDATION_PATH).round(5)

    report = [
        "# Systems Biology and Complexity in Living Networks Report",
        "",
        "This report was generated from synthetic educational systems-biology data.",
        "",
        "## Network Summary",
        "",
        dataframe_to_markdown(network[["node_id", "node_type", "pathway", "degree"]]),
        "",
        "## Pathway Activity",
        "",
        dataframe_to_markdown(pathway),
        "",
        "## Validation Metrics",
        "",
        dataframe_to_markdown(validation),
        "",
        "## Limitations",
        "",
        "- These examples are methodological scaffolds, not production systems-biology workflows.",
        "- Network edges are synthetic and should not be interpreted as curated biological truth.",
        "- Pathway scores are simplified summaries.",
        "- Flux-balance scaffolds are not optimization solvers.",
        "- Real applications require biological review, database-version documentation, model validation, and uncertainty communication.",
        "",
    ]

    REPORT_PATH.write_text("\n".join(report))

    print("\n".join(report))
    print(f"Saved: {REPORT_PATH}")


if __name__ == "__main__":
    main()
