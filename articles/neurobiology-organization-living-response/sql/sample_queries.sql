-- Example SQL queries for neurobiology and living-response workflows.

.headers on
.mode column

SELECT
    unit_code,
    unit_type,
    functional_role
FROM neural_units
ORDER BY unit_code;

SELECT
    start_time,
    end_time,
    input_amplitude,
    description
FROM input_pulses
ORDER BY pulse_id;

SELECT
    source_unit,
    target_unit,
    weight_value,
    interaction_type
FROM network_weights
ORDER BY weight_id;

SELECT
    scenario_name,
    recovery_rate,
    input_gain,
    noise_pressure,
    stress_load,
    connectivity_integrity
FROM neural_condition_scenarios
ORDER BY scenario_id;

SELECT
    dataset_name,
    source_name,
    analytical_method,
    processing_step,
    uncertainty_notes
FROM provenance_records
ORDER BY recorded_at DESC;
