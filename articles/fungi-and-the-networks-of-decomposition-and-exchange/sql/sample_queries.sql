-- Example SQL queries for fungal decomposition and exchange workflows.

.headers on
.mode column

SELECT
    guild_name,
    functional_description,
    decomposition_multiplier
FROM fungal_guilds
ORDER BY guild_id;

SELECT
    site_name,
    temperature,
    moisture,
    lignin_n_ratio,
    guild_name
FROM decomposition_sites
ORDER BY site_id;

SELECT
    site_name,
    mycorrhizal_richness,
    saprotroph_richness,
    pathogen_relative_abundance,
    soil_organic_carbon,
    aggregate_stability
FROM fungal_condition_sites
ORDER BY site_id;

SELECT
    scenario_name,
    recovery_rate,
    carrying_capacity,
    mortality_rate,
    pulse_day,
    pulse_size
FROM recovery_scenarios
ORDER BY scenario_id;

SELECT
    source_node,
    target_node,
    edge_weight
FROM network_edges
ORDER BY edge_id;

SELECT
    dataset_name,
    source_name,
    analytical_method,
    processing_step,
    uncertainty_notes
FROM provenance_records
ORDER BY recorded_at DESC;
