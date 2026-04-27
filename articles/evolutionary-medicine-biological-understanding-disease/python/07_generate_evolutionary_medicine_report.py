"""
Generate an evolutionary medicine report.

Run from article directory:
    python python/07_generate_evolutionary_medicine_report.py
"""

from pathlib import Path
import subprocess
import sys
import pandas as pd

from evolutionary_medicine_core import dataframe_to_markdown


ARTICLE_DIR = Path(__file__).resolve().parents[1]
REPORT_PATH = ARTICLE_DIR / "outputs" / "reports" / "evolutionary_medicine_report.md"

REQUIRED_OUTPUTS = [
    ("01_antimicrobial_resistance_selection.py", ARTICLE_DIR / "outputs" / "tables" / "resistance_selection_summary.csv"),
    ("02_mismatch_risk_scores.py", ARTICLE_DIR / "outputs" / "tables" / "mismatch_risk_scores.csv"),
    ("03_life_history_tradeoffs.py", ARTICLE_DIR / "outputs" / "tables" / "life_history_tradeoffs.csv"),
    ("04_somatic_evolution.py", ARTICLE_DIR / "outputs" / "tables" / "somatic_evolution_summary.csv"),
    ("05_defense_thresholds.py", ARTICLE_DIR / "outputs" / "tables" / "defense_threshold_summary.csv"),
    ("06_provenance_manifest.py", ARTICLE_DIR / "outputs" / "manifests" / "provenance_manifest.csv"),
]


def ensure_outputs() -> None:
    for script, path in REQUIRED_OUTPUTS:
        if not path.exists():
            subprocess.run([sys.executable, str(ARTICLE_DIR / "python" / script)], check=True)


def main() -> None:
    REPORT_PATH.parent.mkdir(parents=True, exist_ok=True)
    ensure_outputs()

    resistance = pd.read_csv(ARTICLE_DIR / "outputs" / "tables" / "resistance_selection_summary.csv").round(5)
    mismatch = pd.read_csv(ARTICLE_DIR / "outputs" / "tables" / "mismatch_risk_scores.csv").round(4)
    life_history = pd.read_csv(ARTICLE_DIR / "outputs" / "tables" / "life_history_tradeoffs.csv").round(4)
    somatic = pd.read_csv(ARTICLE_DIR / "outputs" / "tables" / "somatic_evolution_summary.csv").round(2)
    defense = pd.read_csv(ARTICLE_DIR / "outputs" / "tables" / "defense_threshold_summary.csv").round(4)

    report = [
        "# Evolutionary Medicine and the Biological Understanding of Disease",
        "",
        "This report was generated from synthetic educational evolutionary-medicine data.",
        "",
        "## Antimicrobial Resistance Selection",
        "",
        dataframe_to_markdown(resistance),
        "",
        "## Evolutionary Mismatch Scores",
        "",
        dataframe_to_markdown(mismatch[["trait_system", "biological_domain", "mismatch_distance", "weighted_mismatch_score"]]),
        "",
        "## Life-History Trade-Offs",
        "",
        dataframe_to_markdown(life_history[["scenario", "total_allocation", "maintenance_risk_index", "inflammation_pressure_index"]]),
        "",
        "## Somatic Evolution Summary",
        "",
        dataframe_to_markdown(somatic),
        "",
        "## Defense Threshold Summary",
        "",
        dataframe_to_markdown(defense[["defense_system", "defense_activated", "threshold_margin", "risk_balance_index"]]),
        "",
        "## Interpretation Warning",
        "",
        "These examples are educational scaffolds. Evolutionary medicine can organize biological reasoning, but clinical and public-health decisions require evidence, expert review, ethical judgment, and appropriate institutional standards.",
        "",
    ]

    REPORT_PATH.write_text("\n".join(report))

    print("\n".join(report))
    print(f"Saved: {REPORT_PATH}")


if __name__ == "__main__":
    main()
