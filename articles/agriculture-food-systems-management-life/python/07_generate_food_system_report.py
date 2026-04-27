"""
Generate an agriculture and food-system report.

Run from article directory:
    python python/07_generate_food_system_report.py
"""

from pathlib import Path
import subprocess
import sys
import pandas as pd

from agriculture_food_systems_core import dataframe_to_markdown


ARTICLE_DIR = Path(__file__).resolve().parents[1]
REPORT_PATH = ARTICLE_DIR / "outputs" / "reports" / "agriculture_food_system_report.md"

REQUIRED_OUTPUTS = [
    ("01_food_system_indicators.py", ARTICLE_DIR / "outputs" / "tables" / "food_system_indicators.csv"),
    ("02_biodiversity_resilience.py", ARTICLE_DIR / "outputs" / "tables" / "biodiversity_resilience_scores.csv"),
    ("03_soil_carbon_change.py", ARTICLE_DIR / "outputs" / "tables" / "soil_carbon_change.csv"),
    ("04_diet_diversity.py", ARTICLE_DIR / "outputs" / "tables" / "diet_diversity_scores.csv"),
    ("05_food_loss_accounting.py", ARTICLE_DIR / "outputs" / "tables" / "food_loss_accounting.csv"),
    ("06_provenance_manifest.py", ARTICLE_DIR / "outputs" / "manifests" / "provenance_manifest.csv"),
]


def ensure_outputs() -> None:
    for script, path in REQUIRED_OUTPUTS:
        if not path.exists():
            subprocess.run([sys.executable, str(ARTICLE_DIR / "python" / script)], check=True)


def main() -> None:
    REPORT_PATH.parent.mkdir(parents=True, exist_ok=True)
    ensure_outputs()

    indicators = pd.read_csv(ARTICLE_DIR / "outputs" / "tables" / "food_system_indicators.csv").round(5)
    resilience = pd.read_csv(ARTICLE_DIR / "outputs" / "tables" / "biodiversity_resilience_scores.csv").round(4)
    soil = pd.read_csv(ARTICLE_DIR / "outputs" / "tables" / "soil_carbon_change.csv").round(4)
    diet = pd.read_csv(ARTICLE_DIR / "outputs" / "tables" / "diet_diversity_scores.csv")
    loss = pd.read_csv(ARTICLE_DIR / "outputs" / "tables" / "food_loss_accounting.csv").round(4)

    report = [
        "# Agriculture, Food Systems, and the Management of Life",
        "",
        "This report was generated from synthetic educational agriculture and food-system data.",
        "",
        "## Food-System Indicators",
        "",
        dataframe_to_markdown(indicators[["system", "yield_t_ha", "water_productivity_t_per_m3", "nutrient_use_efficiency", "food_loss_rate"]]),
        "",
        "## Biodiversity-Resilience Scores",
        "",
        dataframe_to_markdown(resilience[["farm_system", "resilience_index", "crop_diversity", "soil_biological_function"]]),
        "",
        "## Soil Organic Carbon Change",
        "",
        dataframe_to_markdown(soil[["system", "delta_soc_t_ha", "annualized_soc_change_t_ha_yr"]]),
        "",
        "## Diet Diversity",
        "",
        dataframe_to_markdown(diet[["household_id", "diet_diversity_score", "low_diversity_flag", "food_access_constraint"]]),
        "",
        "## Food Loss and Waste",
        "",
        dataframe_to_markdown(loss[["system", "total_loss_waste_tonnes", "total_loss_waste_rate"]]),
        "",
        "## Interpretation Warning",
        "",
        "These outputs are educational scaffolds. Agriculture and food-system decisions require empirical data, local ecological context, farmer and community knowledge, nutrition expertise, public-health review, and governance judgment.",
        "",
    ]

    REPORT_PATH.write_text("\n".join(report))

    print("\n".join(report))
    print(f"Saved: {REPORT_PATH}")


if __name__ == "__main__":
    main()
