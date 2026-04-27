"""
Generate a compact reproducibility report.

Run:
    python python/reproducibility_report.py
"""

from pathlib import Path

import pandas as pd

from reproducibility_core import measurement_quality_summary, uncertainty_budget


ARTICLE_DIR = Path(__file__).resolve().parents[1]


def main() -> None:
    measurements = pd.read_csv(ARTICLE_DIR / "data" / "measurements.csv")
    components = pd.read_csv(ARTICLE_DIR / "data" / "uncertainty_components.csv")
    artifacts = pd.read_csv(ARTICLE_DIR / "data" / "artifact_manifest.csv")

    quality = measurement_quality_summary(measurements)
    uncertainty = uncertainty_budget(components)

    report = [
        "# Reproducibility Report",
        "",
        f"- Total records: {quality.n_total}",
        f"- Completeness rate: {quality.completeness_rate:.4f}",
        f"- QC pass rate: {quality.qc_pass_rate:.4f}",
        f"- Mean pass value: {quality.mean_value:.4f}",
        f"- Coefficient of variation: {quality.coefficient_of_variation:.4f}",
        f"- Expanded uncertainty: {uncertainty['expanded_uncertainty'].iloc[0]:.4f}",
        f"- Artifacts tracked: {len(artifacts)}",
        "",
        "This report is generated from synthetic educational data.",
    ]

    print("\n".join(report))


if __name__ == "__main__":
    main()
