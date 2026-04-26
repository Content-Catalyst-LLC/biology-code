-- Example SQL queries for biosphere life-support workflows.

.headers on
.mode column

SELECT
    unit_code,
    unit_type,
    biome,
    region
FROM biosphere_units
ORDER BY unit_code;

SELECT
    scenario_name,
    emissions_start,
    emissions_growth,
    land_uptake_mean,
    ocean_uptake_mean,
    disturbance_mean
FROM carbon_scenarios
ORDER BY scenario_name;

SELECT
    dataset_name,
    source_name,
    observation_method,
    processing_step,
    uncertainty_notes
FROM provenance_records
ORDER BY recorded_at DESC;
