"""
Core utilities for agriculture and food-system workflows.

All examples are synthetic and educational.
"""

from __future__ import annotations

from pathlib import Path
import hashlib

import pandas as pd


def calculate_food_system_indicators(systems: pd.DataFrame) -> pd.DataFrame:
    """Calculate yield, water productivity, nutrient efficiency, and food-loss rate."""
    result = systems.copy()
    result["yield_t_ha"] = result["production_tonnes"] / result["area_hectares"]
    result["water_productivity_t_per_m3"] = result["production_tonnes"] / result["water_used_m3"]
    result["nutrient_use_efficiency"] = result["nutrient_harvested_kg"] / result["nutrient_input_kg"]
    result["food_loss_rate"] = result["food_lost_tonnes"] / result["production_tonnes"]
    return result.sort_values("yield_t_ha", ascending=False)


def calculate_biodiversity_resilience(data: pd.DataFrame) -> pd.DataFrame:
    """Calculate a conceptual biodiversity-resilience score."""
    result = data.copy()
    result["resilience_index"] = (
        0.25 * result["crop_diversity"]
        + 0.25 * result["soil_biological_function"]
        + 0.20 * result["landscape_heterogeneity"]
        + 0.15 * result["pollinator_habitat"]
        + 0.15 * result["natural_enemy_habitat"]
    )
    return result.sort_values("resilience_index", ascending=False)


def calculate_soil_carbon_change(soil: pd.DataFrame) -> pd.DataFrame:
    """Calculate soil organic carbon change."""
    result = soil.copy()
    result["delta_soc_t_ha"] = result["soc_t1_t_ha"] - result["soc_t0_t_ha"]
    result["annualized_soc_change_t_ha_yr"] = result["delta_soc_t_ha"] / result["years"]
    return result.sort_values("annualized_soc_change_t_ha_yr", ascending=False)


def calculate_diet_diversity(diet: pd.DataFrame) -> pd.DataFrame:
    """Calculate a simplified diet-diversity score."""
    result = diet.copy()
    food_groups = ["grains", "legumes", "fruits", "vegetables", "animal_source", "nuts_seeds", "dairy"]
    result["diet_diversity_score"] = result[food_groups].sum(axis=1)
    result["low_diversity_flag"] = result["diet_diversity_score"] < 4
    return result.sort_values("diet_diversity_score", ascending=False)


def calculate_food_loss_stages(loss: pd.DataFrame) -> pd.DataFrame:
    """Calculate total and stage-specific food loss and waste."""
    result = loss.copy()
    stage_cols = [
        "harvest_loss_tonnes",
        "storage_loss_tonnes",
        "processing_loss_tonnes",
        "retail_loss_tonnes",
        "consumer_waste_tonnes",
    ]
    result["total_loss_waste_tonnes"] = result[stage_cols].sum(axis=1)
    result["total_loss_waste_rate"] = result["total_loss_waste_tonnes"] / result["production_tonnes"]
    return result.sort_values("total_loss_waste_rate", ascending=False)


def sha256_file(path: Path) -> str:
    """Calculate SHA-256 checksum for a file."""
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for block in iter(lambda: handle.read(65536), b""):
            digest.update(block)
    return digest.hexdigest()


def safe_sha256(path: Path) -> str:
    """Return a checksum or not-available marker."""
    if path.exists() and path.is_file():
        return sha256_file(path)
    return "not_available"


def dataframe_to_markdown(df: pd.DataFrame) -> str:
    """Convert a small DataFrame to markdown without external dependencies."""
    headers = list(df.columns)
    lines = [
        "| " + " | ".join(headers) + " |",
        "| " + " | ".join(["---"] * len(headers)) + " |",
    ]
    for _, row in df.iterrows():
        lines.append("| " + " | ".join(str(row[col]) for col in headers) + " |")
    return "\n".join(lines)
