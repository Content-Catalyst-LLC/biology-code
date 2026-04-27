"""
Generate a biology ethics report.

Run from article directory:
    python python/07_generate_biology_ethics_report.py
"""

from pathlib import Path
import subprocess
import sys
import pandas as pd

from biology_ethics_core import dataframe_to_markdown


ARTICLE_DIR = Path(__file__).resolve().parents[1]
REPORT_PATH = ARTICLE_DIR / "outputs" / "reports" / "biology_ethics_report.md"

REQUIRED_OUTPUTS = [
    ("01_ethical_review_scores.py", ARTICLE_DIR / "outputs" / "tables" / "ethical_review_scores.csv"),
    ("02_consent_completeness.py", ARTICLE_DIR / "outputs" / "tables" / "consent_completeness.csv"),
    ("03_justice_adjusted_benefit.py", ARTICLE_DIR / "outputs" / "tables" / "justice_adjusted_benefit.csv"),
    ("04_ecological_risk.py", ARTICLE_DIR / "outputs" / "tables" / "ecological_risk_scores.csv"),
    ("05_governance_flags.py", ARTICLE_DIR / "outputs" / "tables" / "governance_flags.csv"),
    ("06_provenance_manifest.py", ARTICLE_DIR / "outputs" / "manifests" / "provenance_manifest.csv"),
]


def ensure_outputs() -> None:
    for script, path in REQUIRED_OUTPUTS:
        if not path.exists():
            subprocess.run([sys.executable, str(ARTICLE_DIR / "python" / script)], check=True)


def main() -> None:
    REPORT_PATH.parent.mkdir(parents=True, exist_ok=True)
    ensure_outputs()

    ethical = pd.read_csv(ARTICLE_DIR / "outputs" / "tables" / "ethical_review_scores.csv").round(4)
    consent = pd.read_csv(ARTICLE_DIR / "outputs" / "tables" / "consent_completeness.csv").round(4)
    justice = pd.read_csv(ARTICLE_DIR / "outputs" / "tables" / "justice_adjusted_benefit.csv").round(4)
    ecological = pd.read_csv(ARTICLE_DIR / "outputs" / "tables" / "ecological_risk_scores.csv").round(4)
    governance = pd.read_csv(ARTICLE_DIR / "outputs" / "tables" / "governance_flags.csv")

    report = [
        "# Biology, Ethics, and the Human Understanding of Life",
        "",
        "This report was generated from synthetic educational biology-ethics data.",
        "",
        "## Ethical Review Scores",
        "",
        dataframe_to_markdown(ethical[["project", "domain", "ethical_review_score", "requires_deeper_review"]]),
        "",
        "## Consent Completeness",
        "",
        dataframe_to_markdown(consent[["study", "participant_group", "consent_completeness", "review_flag"]]),
        "",
        "## Justice-Adjusted Benefit",
        "",
        dataframe_to_markdown(justice[["intervention", "expected_benefit", "inequality_penalty", "justice_adjusted_benefit"]]),
        "",
        "## Ecological Risk",
        "",
        dataframe_to_markdown(ecological[["project", "ecological_risk", "reversibility_adjusted_risk", "monitoring_gap"]]),
        "",
        "## Governance Flags",
        "",
        dataframe_to_markdown(governance[["project", "n_governance_requirements"]]),
        "",
        "## Interpretation Warning",
        "",
        "These outputs are educational scaffolds. Ethical decisions in biology require human deliberation, institutional review, community participation, legal compliance, domain expertise, and accountable governance.",
        "",
    ]

    REPORT_PATH.write_text("\n".join(report))

    print("\n".join(report))
    print(f"Saved: {REPORT_PATH}")


if __name__ == "__main__":
    main()
