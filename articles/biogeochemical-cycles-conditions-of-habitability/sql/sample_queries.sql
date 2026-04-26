-- Example SQL queries for biogeochemical cycles and habitability workflows.

.headers on
.mode column

SELECT
    reservoir_name,
    cycle_name,
    reservoir_type
FROM reservoirs
ORDER BY cycle_name, reservoir_name;

SELECT
    cycle_name,
    flux_name,
    flux_direction,
    value,
    unit_of_measure
FROM flux_records
ORDER BY cycle_name, flux_name;

SELECT
    scenario_name,
    oxygen_stability_change,
    nutrient_loading_change,
    acidification_pressure_change
FROM scenarios
ORDER BY scenario_name;

SELECT
    dataset_name,
    source_name,
    analytical_method,
    processing_step,
    uncertainty_notes
FROM provenance_records
ORDER BY recorded_at DESC;
