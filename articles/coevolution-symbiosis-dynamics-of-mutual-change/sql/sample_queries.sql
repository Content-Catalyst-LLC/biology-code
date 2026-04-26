-- Example SQL queries for coevolution and symbiosis workflows.

.headers on
.mode column

SELECT
    scenario_name,
    stress,
    symbiont_load,
    (benefit_intercept - benefit_stress_slope * stress) AS benefit,
    (cost_intercept + cost_stress_slope * stress) AS cost,
    symbiont_load * (
        (benefit_intercept - benefit_stress_slope * stress)
        - (cost_intercept + cost_stress_slope * stress)
    ) AS net_effect
FROM benefit_cost_scenarios
ORDER BY scenario_id;

SELECT
    scenario_name,
    host_initial,
    symbiont_initial,
    host_feedback,
    symbiont_feedback,
    steps
FROM reciprocal_frequency_scenarios
ORDER BY scenario_id;

SELECT
    scenario_name,
    host_defense,
    pathogen_escape,
    feedback,
    steps
FROM host_pathogen_scenarios
ORDER BY scenario_id;

SELECT
    focal,
    partner,
    interaction_weight,
    partner_reliability,
    interaction_weight * partner_reliability AS weighted_support,
    interaction_type
FROM network_interactions
ORDER BY focal, partner;

SELECT
    site_name,
    partner_presence,
    interaction_stability,
    environmental_stress,
    cheating_pressure,
    transmission_reliability,
    functional_redundancy
FROM symbiosis_condition_sites
ORDER BY site_id;

SELECT
    dataset_name,
    source_name,
    analytical_method,
    processing_step,
    uncertainty_notes
FROM provenance_records
ORDER BY recorded_at DESC;
