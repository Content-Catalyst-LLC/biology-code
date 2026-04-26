-- Example SQL queries for population dynamics and ecological modeling workflows.

.headers on
.mode column

SELECT
    population_id,
    species_code,
    habitat_type,
    initial_population
FROM populations
ORDER BY population_id;

SELECT
    stage,
    survival,
    transition_probability,
    fecundity
FROM vital_rates
WHERE population_id = 'pop_A'
ORDER BY vital_rate_id;

SELECT
    destination_stage,
    source_stage,
    value
FROM stage_matrix_entries
WHERE matrix_name = 'baseline_stage_matrix'
ORDER BY entry_id;

SELECT
    scenario_name,
    initial_population,
    growth_rate_mean,
    carrying_capacity_mean,
    harvest,
    catastrophe_probability
FROM scenario_definitions
ORDER BY scenario_name;

SELECT
    scenario_name,
    initial_occupancy,
    colonization_rate,
    extinction_rate,
    years
FROM metapopulation_scenarios
ORDER BY scenario_name;

SELECT
    dataset_name,
    source_name,
    analytical_method,
    processing_step,
    uncertainty_notes
FROM provenance_records
ORDER BY recorded_at DESC;
