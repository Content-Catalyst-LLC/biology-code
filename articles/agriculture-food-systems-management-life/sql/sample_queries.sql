.mode column
.headers on

SELECT
    system,
    ROUND(production_tonnes / area_hectares, 4) AS yield_t_ha,
    ROUND(production_tonnes / water_used_m3, 8) AS water_productivity_t_per_m3,
    ROUND(nutrient_harvested_kg / nutrient_input_kg, 4) AS nutrient_use_efficiency,
    ROUND(food_lost_tonnes / production_tonnes, 4) AS food_loss_rate
FROM production_systems
ORDER BY yield_t_ha DESC;

SELECT
    farm_system,
    ROUND(
        0.25 * crop_diversity
        + 0.25 * soil_biological_function
        + 0.20 * landscape_heterogeneity
        + 0.15 * pollinator_habitat
        + 0.15 * natural_enemy_habitat,
        4
    ) AS resilience_index
FROM biodiversity_resilience
ORDER BY resilience_index DESC;

SELECT
    system,
    ROUND(soc_t1_t_ha - soc_t0_t_ha, 4) AS delta_soc_t_ha,
    ROUND((soc_t1_t_ha - soc_t0_t_ha) / years, 4) AS annualized_soc_change_t_ha_yr
FROM soil_carbon
ORDER BY annualized_soc_change_t_ha_yr DESC;

SELECT
    household_id,
    grains + legumes + fruits + vegetables + animal_source + nuts_seeds + dairy AS diet_diversity_score,
    food_access_constraint
FROM diet_diversity
ORDER BY diet_diversity_score DESC;

SELECT
    system,
    ROUND(
        harvest_loss_tonnes + storage_loss_tonnes + processing_loss_tonnes + retail_loss_tonnes + consumer_waste_tonnes,
        4
    ) AS total_loss_waste_tonnes,
    ROUND(
        (harvest_loss_tonnes + storage_loss_tonnes + processing_loss_tonnes + retail_loss_tonnes + consumer_waste_tonnes) / production_tonnes,
        4
    ) AS total_loss_waste_rate
FROM food_loss_stages
ORDER BY total_loss_waste_rate DESC;
