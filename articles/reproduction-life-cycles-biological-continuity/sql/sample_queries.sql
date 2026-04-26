-- Example SQL queries for reproduction, life cycles, and biological continuity workflows.

.headers on
.mode column

SELECT
    stage_name,
    stage_order,
    primary_function,
    vulnerability_notes
FROM life_stages
ORDER BY stage_order;

SELECT
    destination_stage,
    source_stage,
    value,
    biological_interpretation
FROM stage_matrix_entries
WHERE matrix_name = 'baseline_life_cycle_matrix'
ORDER BY entry_id;

SELECT
    scenario_name,
    stage_name,
    count
FROM initial_stage_vectors
ORDER BY scenario_name, stage_name;

SELECT
    unit_code,
    fecundity,
    juvenile_survival,
    adult_survival,
    maturation_rate,
    dormancy_or_buffering,
    environmental_stress
FROM life_history_units
ORDER BY unit_code;

SELECT
    scenario_name,
    adult_survival_multiplier,
    juvenile_survival_multiplier,
    environmental_stress_increase,
    notes
FROM reproductive_scenarios
ORDER BY scenario_name;

SELECT
    dataset_name,
    source_name,
    analytical_method,
    processing_step,
    uncertainty_notes
FROM provenance_records
ORDER BY recorded_at DESC;
