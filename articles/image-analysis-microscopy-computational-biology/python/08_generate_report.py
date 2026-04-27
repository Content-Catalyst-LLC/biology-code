"""
Generate compact microscopy image-analysis report.

Run from article directory:
    python python/08_generate_report.py
"""

from pathlib import Path
import subprocess
import sys

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
FEATURES_PATH = ARTICLE_DIR / "outputs" / "tables" / "object_features.csv"
VALIDATION_PATH = ARTICLE_DIR / "outputs" / "tables" / "segmentation_validation_metrics.csv"
COLOC_PATH = ARTICLE_DIR / "outputs" / "tables" / "colocalization_summary.csv"
TRACKING_PATH = ARTICLE_DIR / "outputs" / "tables" / "tracking_summary.csv"
REPORT_PATH = ARTICLE_DIR / "outputs" / "reports" / "microscopy_image_analysis_report.md"


def ensure_inputs() -> None:
    scripts = [
        ("03_object_feature_extraction.py", FEATURES_PATH),
        ("04_segmentation_validation.py", VALIDATION_PATH),
        ("05_colocalization_summary.py", COLOC_PATH),
        ("06_tracking_summary.py", TRACKING_PATH),
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

    features = pd.read_csv(FEATURES_PATH).round(5)
    validation = pd.read_csv(VALIDATION_PATH).round(5)
    coloc = pd.read_csv(COLOC_PATH).round(5)
    tracking = pd.read_csv(TRACKING_PATH).round(5)

    report = [
        "# Image Analysis, Microscopy, and Computational Biology Report",
        "",
        "This report was generated from synthetic educational microscopy image-analysis data.",
        "",
        "## Object Features",
        "",
        dataframe_to_markdown(features),
        "",
        "## Segmentation Validation",
        "",
        dataframe_to_markdown(validation),
        "",
        "## Colocalization Summary",
        "",
        dataframe_to_markdown(coloc),
        "",
        "## Tracking Summary",
        "",
        dataframe_to_markdown(tracking),
        "",
        "## Limitations",
        "",
        "- These examples are methodological scaffolds, not production microscopy workflows.",
        "- Threshold segmentation is sensitive to image quality and acquisition conditions.",
        "- Feature extraction depends on segmentation quality.",
        "- Real applications require acquisition metadata, validation, biological review, and quality-control procedures.",
        "",
    ]

    REPORT_PATH.write_text("\n".join(report))

    print("\n".join(report))
    print(f"Saved: {REPORT_PATH}")


if __name__ == "__main__":
    main()
