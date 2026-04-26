-- Example SQL queries for plant biology workflows.

.headers on
.mode column

SELECT
    site_name,
    gross_primary_productivity,
    autotrophic_respiration,
    heterotrophic_respiration,
    gross_primary_productivity - autotrophic_respiration AS npp,
    gross_primary_productivity - (autotrophic_respiration + heterotrophic_respiration) AS nep
FROM productivity_sites
ORDER BY site_id;

SELECT
    scenario_name,
    alpha,
    amax,
    dark_respiration
FROM light_response_scenarios
ORDER BY scenario_id;

SELECT
    scenario_name,
    initial_biomass,
    regrowth_rate,
    carrying_capacity,
    mortality_rate,
    pulse_day,
    pulse_size
FROM biomass_recovery_scenarios
ORDER BY scenario_id;

SELECT
    site_name,
    canopy_condition,
    water_availability,
    nutrient_status,
    soil_function,
    disease_pressure,
    drought_stress,
    regeneration_support
FROM plant_condition_sites
ORDER BY site_id;

SELECT
    dataset_name,
    source_name,
    analytical_method,
    processing_step,
    uncertainty_notes
FROM provenance_records
ORDER BY recorded_at DESC;
