-- Example SQL queries for immunology and biological defense workflows.

.headers on
.mode column

SELECT
    compartment_name,
    description,
    example_measure
FROM immune_compartments
ORDER BY compartment_id;

SELECT
    scenario_name,
    pathogen_growth_rate,
    clearance_coefficient,
    immune_activation_rate,
    immune_decay_rate,
    damage_generation_rate,
    repair_resolution_rate
FROM immune_scenarios
ORDER BY scenario_id;

SELECT
    threshold_name,
    value,
    description
FROM immune_thresholds
ORDER BY threshold_id;

SELECT
    scenario_name,
    clearance_capacity,
    activation_capacity,
    regulatory_capacity,
    damage_pressure,
    stress_load,
    memory_support
FROM immune_condition_scenarios
ORDER BY condition_id;

SELECT
    dataset_name,
    source_name,
    analytical_method,
    processing_step,
    uncertainty_notes
FROM provenance_records
ORDER BY recorded_at DESC;
