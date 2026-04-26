-- Example SQL queries for microbiology and hidden-majority workflows.

.headers on
.mode column

SELECT
    environment_name,
    temperature,
    ph,
    carrying_capacity,
    baseline_growth_rate
FROM growth_environments
ORDER BY environment_id;

SELECT
    scenario_name,
    initial_substrate,
    mu_max,
    half_saturation_constant,
    yield_coefficient
FROM monod_scenarios
ORDER BY scenario_id;

SELECT
    scenario_name,
    recovery_rate,
    carrying_capacity,
    mortality_rate,
    pulse_day,
    pulse_size
FROM community_recovery_scenarios
ORDER BY scenario_id;

SELECT
    site_name,
    functional_richness,
    nitrification_potential,
    denitrification_balance,
    pathogen_signal,
    organic_overload
FROM microbial_condition_sites
ORDER BY site_id;

SELECT
    process_name,
    description,
    example_context
FROM microbial_processes
ORDER BY process_id;

SELECT
    dataset_name,
    source_name,
    analytical_method,
    processing_step,
    uncertainty_notes
FROM provenance_records
ORDER BY recorded_at DESC;
