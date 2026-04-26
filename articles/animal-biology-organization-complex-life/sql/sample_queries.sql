-- Example SQL queries for animal biology workflows.

.headers on
.mode column

SELECT
    species_name,
    body_mass_kg,
    habitat,
    exposure_risk
FROM species_traits
ORDER BY body_mass_kg;

SELECT
    scenario_name,
    initial_population,
    growth_rate,
    carrying_capacity
FROM population_recovery_scenarios
ORDER BY scenario_id;

SELECT
    scenario_name,
    hazard_rate
FROM survival_scenarios
ORDER BY scenario_id;

SELECT
    from_stage,
    to_stage,
    value
FROM stage_matrix
ORDER BY matrix_id;

SELECT
    site_name,
    habitat_quality,
    food_availability,
    disease_pressure,
    heat_stress,
    reproductive_support,
    movement_connectivity
FROM animal_condition_sites
ORDER BY site_id;

SELECT
    dataset_name,
    source_name,
    analytical_method,
    processing_step,
    uncertainty_notes
FROM provenance_records
ORDER BY recorded_at DESC;
