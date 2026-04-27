"""
Generate compact computational ecology report.

Run from article directory:
    python python/07_generate_report.py
"""

from pathlib import Path
import subprocess
import sys

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
HABITAT_PATH = ARTICLE_DIR / "outputs" / "tables" / "habitat_suitability.csv"
STRESS_PATH = ARTICLE_DIR / "outputs" / "tables" / "environmental_stress.csv"
VALIDATION_PATH = ARTICLE_DIR / "outputs" / "tables" / "validation_metrics.csv"
REPORT_PATH = ARTICLE_DIR / "outputs" / "reports" / "computational_ecology_report.md"


def ensure_inputs() -> None:
    scripts = [
        ("01_habitat_suitability.py", HABITAT_PATH),
        ("03_environmental_stress_scenarios.py", STRESS_PATH),
        ("05_validation_metrics.py", VALIDATION_PATH),
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

    habitat = pd.read_csv(HABITAT_PATH).round(5)
    stress = pd.read_csv(STRESS_PATH).round(5)
    validation = pd.read_csv(VALIDATION_PATH).round(5)

    report = [
        "# Computational Ecology and Environmental Modeling Report",
        "",
        "This report was generated from synthetic educational ecological and environmental data.",
        "",
        "## Habitat Suitability",
        "",
        dataframe_to_markdown(habitat[["site_id", "suitability", "predicted_presence", "observed_presence"]]),
        "",
        "## Environmental Stress Scenarios",
        "",
        dataframe_to_markdown(stress[["scenario", "stress_index", "relative_resilience"]]),
        "",
        "## Validation Metrics",
        "",
        dataframe_to_markdown(validation),
        "",
        "## Limitations",
        "",
        "- These examples are methodological scaffolds, not operational ecological forecasts.",
        "- Habitat suitability is not confirmed species presence.",
        "- Detection probability, sampling bias, and spatial autocorrelation are not modeled.",
        "- Real applications require empirical validation, spatial review, and domain-specific interpretation.",
        "",
    ]

    REPORT_PATH.write_text("\n".join(report))

    print("\n".join(report))
    print(f"Saved: {REPORT_PATH}")


if __name__ == "__main__":
    main()
