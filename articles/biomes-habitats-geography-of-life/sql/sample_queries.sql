-- Example SQL queries for biomes, habitats, and biogeography workflows.

.headers on
.mode column

SELECT
    biome_name,
    realm,
    defining_gradient
FROM biome_classes
ORDER BY realm, biome_name;

SELECT
    habitat_code,
    biome_name,
    habitat_type,
    substrate,
    dominant_disturbance
FROM habitat_records
ORDER BY habitat_code;

SELECT
    scenario_name,
    area_multiplier,
    land_use_pressure_change,
    connectivity_change
FROM spatial_scenarios
ORDER BY scenario_name;

SELECT
    dataset_name,
    source_name,
    observation_method,
    processing_step,
    uncertainty_notes
FROM provenance_records
ORDER BY recorded_at DESC;
