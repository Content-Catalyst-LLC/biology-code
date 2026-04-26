-- Example SQL queries for physiology and regulation workflows.

.headers on
.mode column

SELECT
    variable_name,
    description,
    example_measure
FROM physiological_variables
ORDER BY variable_id;

SELECT
    scenario_name,
    input_rate,
    sensing_strength,
    signal_decay,
    effector_activation,
    signal_dependent_uptake
FROM feedback_scenarios
ORDER BY scenario_id;

SELECT
    scenario_name,
    feedback_capacity,
    effector_capacity,
    signal_integrity,
    stress_load,
    environmental_pressure,
    recovery_support
FROM physiological_condition_scenarios
ORDER BY condition_id;

SELECT
    threshold_name,
    value,
    description
FROM regulatory_thresholds
ORDER BY threshold_id;

SELECT
    dataset_name,
    source_name,
    analytical_method,
    processing_step,
    uncertainty_notes
FROM provenance_records
ORDER BY recorded_at DESC;
