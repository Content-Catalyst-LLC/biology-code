-- Example SQL queries for biodiversity structure workflows.

.headers on
.mode column

SELECT
    site_code,
    habitat_type,
    fragmentation_pressure,
    restoration_potential,
    protection_status
FROM sites
ORDER BY site_code;

SELECT
    species_code,
    functional_role,
    phylogenetic_group
FROM species
ORDER BY species_code;

SELECT
    species_code,
    body_size,
    trophic_level,
    dispersal
FROM species_traits
ORDER BY species_code;

SELECT
    scenario_name,
    fragmentation_pressure_change,
    restoration_potential_change
FROM priority_scenarios
ORDER BY scenario_name;

SELECT
    dataset_name,
    source_name,
    analytical_method,
    processing_step,
    uncertainty_notes
FROM provenance_records
ORDER BY recorded_at DESC;
