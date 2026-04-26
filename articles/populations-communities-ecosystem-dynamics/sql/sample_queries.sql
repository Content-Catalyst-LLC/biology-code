-- Example SQL queries for population, community, and ecosystem dynamics workflows.

.headers on
.mode column

SELECT
    site_code,
    habitat_type,
    region
FROM sites
ORDER BY site_code;

SELECT
    species_code,
    trophic_role,
    functional_group
FROM species
ORDER BY species_code;

SELECT
    source_species,
    target_species,
    interaction_type,
    interaction_strength
FROM interaction_records
ORDER BY interaction_id;

SELECT
    site_code,
    productivity,
    nutrient_retention,
    disturbance_pressure,
    connectivity
FROM ecosystem_indicators
ORDER BY site_code;

SELECT
    scenario_name,
    disturbance_pressure_change,
    connectivity_change,
    productivity_change
FROM scenario_definitions
ORDER BY scenario_name;

SELECT
    dataset_name,
    source_name,
    analytical_method,
    processing_step,
    uncertainty_notes
FROM provenance_records
ORDER BY recorded_at DESC;
