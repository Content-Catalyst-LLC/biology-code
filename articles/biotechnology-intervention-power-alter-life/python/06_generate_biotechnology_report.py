"""
Generate a biotechnology intervention report.

Run from article directory:
    python python/06_generate_biotechnology_report.py
"""

from pathlib import Path
import subprocess
import sys
import pandas as pd

from biotechnology_intervention_core import dataframe_to_markdown


ARTICLE_DIR = Path(__file__).resolve().parents[1]
REPORT_PATH = ARTICLE_DIR / "outputs" / "reports" / "biotechnology_intervention_report.md"

REQUIRED_OUTPUTS = [
    ("01_intervention_risk_benefit.py", ARTICLE_DIR / "outputs" / "tables" / "intervention_risk_benefit_scores.csv"),
    ("02_containment_probability.py", ARTICLE_DIR / "outputs" / "tables" / "containment_probability.csv"),
    ("03_equity_adjusted_access.py", ARTICLE_DIR / "outputs" / "tables" / "equity_adjusted_access.csv"),
    ("04_ecological_release_scenarios.py", ARTICLE_DIR / "outputs" / "tables" / "ecological_release_risk_scores.csv"),
    ("05_provenance_manifest.py", ARTICLE_DIR / "outputs" / "manifests" / "provenance_manifest.csv"),
]


def ensure_outputs() -> None:
    for script, path in REQUIRED_OUTPUTS:
        if not path.exists():
            subprocess.run([sys.executable, str(ARTICLE_DIR / "python" / script)], check=True)


def main() -> None:
    REPORT_PATH.parent.mkdir(parents=True, exist_ok=True)
    ensure_outputs()

    intervention = pd.read_csv(ARTICLE_DIR / "outputs" / "tables" / "intervention_risk_benefit_scores.csv").round(4)
    containment = pd.read_csv(ARTICLE_DIR / "outputs" / "tables" / "containment_probability.csv")
    access = pd.read_csv(ARTICLE_DIR / "outputs" / "tables" / "equity_adjusted_access.csv").round(4)
    ecological = pd.read_csv(ARTICLE_DIR / "outputs" / "tables" / "ecological_release_risk_scores.csv").round(4)

    report = [
        "# Biotechnology, Intervention, and the Power to Alter Life",
        "",
        "This report was generated from synthetic educational biotechnology intervention data.",
        "",
        "## Intervention Responsibility Scores",
        "",
        dataframe_to_markdown(intervention[["intervention", "domain", "scale", "responsibility_score"]]),
        "",
        "## Containment Probability",
        "",
        dataframe_to_markdown(containment),
        "",
        "## Equity-Adjusted Access",
        "",
        dataframe_to_markdown(access[["intervention", "nominal_availability", "inequality_penalty", "equity_adjusted_access"]]),
        "",
        "## Ecological Release Scenario Scores",
        "",
        dataframe_to_markdown(ecological[["scenario", "risk_score", "governance_buffer", "net_concern_score"]]),
        "",
        "## Interpretation Warning",
        "",
        "These scores are conceptual educational scaffolds. Biotechnology decisions require biosafety review, biosecurity review, ethics, governance, public accountability, empirical evidence, and domain expertise.",
        "",
    ]

    REPORT_PATH.write_text("\n".join(report))

    print("\n".join(report))
    print(f"Saved: {REPORT_PATH}")


if __name__ == "__main__":
    main()
