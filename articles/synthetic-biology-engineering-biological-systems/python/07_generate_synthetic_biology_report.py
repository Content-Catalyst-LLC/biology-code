"""
Generate a synthetic biology engineering report.

Run from article directory:
    python python/07_generate_synthetic_biology_report.py
"""

from pathlib import Path
import subprocess
import sys
import pandas as pd

from synthetic_biology_core import dataframe_to_markdown


ARTICLE_DIR = Path(__file__).resolve().parents[1]
REPORT_PATH = ARTICLE_DIR / "outputs" / "reports" / "synthetic_biology_report.md"

REQUIRED_OUTPUTS = [
    ("01_design_build_test_learn.py", ARTICLE_DIR / "outputs" / "tables" / "dbtl_engineering_scores.csv"),
    ("02_biosensor_signal_to_noise.py", ARTICLE_DIR / "outputs" / "tables" / "biosensor_signal_to_noise.csv"),
    ("03_host_burden.py", ARTICLE_DIR / "outputs" / "tables" / "host_burden_scores.csv"),
    ("04_metabolic_yield.py", ARTICLE_DIR / "outputs" / "tables" / "metabolic_yield.csv"),
    ("05_genetic_circuit_dynamics.py", ARTICLE_DIR / "outputs" / "tables" / "genetic_circuit_summary.csv"),
    ("06_provenance_manifest.py", ARTICLE_DIR / "outputs" / "manifests" / "provenance_manifest.csv"),
]


def ensure_outputs() -> None:
    for script, path in REQUIRED_OUTPUTS:
        if not path.exists():
            subprocess.run([sys.executable, str(ARTICLE_DIR / "python" / script)], check=True)


def main() -> None:
    REPORT_PATH.parent.mkdir(parents=True, exist_ok=True)
    ensure_outputs()

    dbtl = pd.read_csv(ARTICLE_DIR / "outputs" / "tables" / "dbtl_engineering_scores.csv").round(4)
    snr = pd.read_csv(ARTICLE_DIR / "outputs" / "tables" / "biosensor_signal_to_noise.csv").round(4)
    burden = pd.read_csv(ARTICLE_DIR / "outputs" / "tables" / "host_burden_scores.csv").round(4)
    yield_table = pd.read_csv(ARTICLE_DIR / "outputs" / "tables" / "metabolic_yield.csv").round(4)
    circuit = pd.read_csv(ARTICLE_DIR / "outputs" / "tables" / "genetic_circuit_summary.csv").round(4)

    report = [
        "# Synthetic Biology and the Engineering of Biological Systems",
        "",
        "This report was generated from synthetic educational synthetic-biology data.",
        "",
        "## DBTL Engineering Scores",
        "",
        dataframe_to_markdown(dbtl[["design_id", "construct_type", "chassis", "engineering_score"]]),
        "",
        "## Biosensor Signal-to-Noise",
        "",
        dataframe_to_markdown(snr[["design_id", "signal_to_noise", "measurement_unit"]]),
        "",
        "## Host Burden",
        "",
        dataframe_to_markdown(burden[["design_id", "chassis", "burden_score"]]),
        "",
        "## Metabolic Yield",
        "",
        dataframe_to_markdown(yield_table[["run_id", "design_id", "product_yield"]]),
        "",
        "## Genetic Circuit Summary",
        "",
        dataframe_to_markdown(circuit),
        "",
        "## Interpretation Warning",
        "",
        "These outputs are educational scaffolds. Synthetic biology designs require sequence verification, calibrated measurement, experimental validation, biosafety review, biosecurity review, and responsible governance.",
        "",
    ]

    REPORT_PATH.write_text("\n".join(report))

    print("\n".join(report))
    print(f"Saved: {REPORT_PATH}")


if __name__ == "__main__":
    main()
