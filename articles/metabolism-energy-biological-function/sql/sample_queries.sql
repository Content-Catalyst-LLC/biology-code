-- Example SQL queries for metabolism workflows.

.headers on
.mode column

SELECT
    condition_name,
    COUNT(*) AS n_observations,
    MIN(time_h) AS first_time_h,
    MAX(time_h) AS last_time_h,
    MIN(abundance) AS min_abundance,
    MAX(abundance) AS max_abundance
FROM growth_observations
GROUP BY condition_name
ORDER BY condition_name;

SELECT
    experiment_id,
    biomass_final_g_L - biomass_initial_g_L AS delta_biomass_g_L,
    substrate_consumed_g_L,
    (biomass_final_g_L - biomass_initial_g_L) / substrate_consumed_g_L AS Yxs_g_g,
    product_g_L / substrate_consumed_g_L AS product_fraction,
    maintenance_estimate_g_L / substrate_consumed_g_L AS maintenance_fraction
FROM substrate_biomass_observations
ORDER BY Yxs_g_g DESC;

SELECT
    scenario_id,
    substrate_input,
    substrate_to_growth / substrate_input AS growth_fraction,
    substrate_to_maintenance / substrate_input AS maintenance_fraction,
    substrate_to_product / substrate_input AS product_fraction,
    substrate_loss / substrate_input AS loss_fraction,
    substrate_input - substrate_to_growth - substrate_to_maintenance - substrate_to_product - substrate_loss AS mass_balance_residual
FROM energy_budget_scenarios
ORDER BY scenario_id;

SELECT
    sample_id,
    MIN(oxygen_mg_L) AS min_oxygen_mg_L,
    MAX(oxygen_mg_L) AS max_oxygen_mg_L,
    MAX(oxygen_mg_L) - MIN(oxygen_mg_L) AS oxygen_decline_mg_L
FROM respirometry_observations
GROUP BY sample_id
ORDER BY oxygen_decline_mg_L DESC;

SELECT
    reaction_id,
    lower_bound,
    upper_bound,
    objective_weight
FROM flux_reactions
ORDER BY objective_weight DESC;

SELECT
    site_name,
    substrate_availability,
    energy_conversion,
    redox_balance,
    growth_capacity,
    maintenance_resilience,
    pathway_integration,
    stress_penalty,
    0.16 * substrate_availability +
    0.17 * energy_conversion +
    0.15 * redox_balance +
    0.14 * growth_capacity +
    0.14 * maintenance_resilience +
    0.14 * pathway_integration +
    0.10 * (1 - stress_penalty) AS metabolic_condition_score
FROM metabolic_condition_sites
ORDER BY metabolic_condition_score DESC;

SELECT
    dataset_name,
    source_name,
    analytical_method,
    processing_step,
    uncertainty_notes
FROM provenance_records
ORDER BY recorded_at DESC;
