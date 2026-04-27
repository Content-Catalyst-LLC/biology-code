"""
Generate a compact machine-learning report.

Run from the article directory:
    python python/05_generate_ml_report.py
"""

from pathlib import Path
import subprocess
import sys

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
REPORT_PATH = ARTICLE_DIR / "outputs" / "reports" / "machine_learning_life_sciences_report.md"

REQUIRED = [
    ("01_train_biomarker_classifier.py", ARTICLE_DIR / "outputs" / "tables" / "training_validation_metrics.csv"),
    ("02_external_validation.py", ARTICLE_DIR / "outputs" / "tables" / "external_validation_metrics.csv"),
    ("03_feature_importance_report.py", ARTICLE_DIR / "outputs" / "tables" / "feature_importance.csv"),
    ("04_model_provenance_manifest.py", ARTICLE_DIR / "outputs" / "tables" / "model_provenance_manifest.csv"),
]


def ensure_outputs() -> None:
    for script, path in REQUIRED:
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
    ensure_outputs()

    training = pd.read_csv(ARTICLE_DIR / "outputs" / "tables" / "training_validation_metrics.csv").round(5)
    external = pd.read_csv(ARTICLE_DIR / "outputs" / "tables" / "external_validation_metrics.csv").round(5)
    importance = pd.read_csv(ARTICLE_DIR / "outputs" / "tables" / "feature_importance.csv").round(5)

    report = [
        "# Machine Learning in the Life Sciences Report",
        "",
        "This report was generated from synthetic educational life-science data.",
        "",
        "## Training/Validation Metrics",
        "",
        dataframe_to_markdown(training),
        "",
        "## External Validation Metrics",
        "",
        dataframe_to_markdown(external),
        "",
        "## Feature Importance",
        "",
        dataframe_to_markdown(importance[["feature", "importance", "feature_mean", "feature_sd"]]),
        "",
        "## Interpretation Warning",
        "",
        "Feature importance is not biological mechanism. Model performance on synthetic examples is not evidence of clinical, ecological, or biological validity.",
        "",
    ]

    REPORT_PATH.write_text("\n".join(report))

    print("\n".join(report))
    print(f"Saved: {REPORT_PATH}")


if __name__ == "__main__":
    main()
