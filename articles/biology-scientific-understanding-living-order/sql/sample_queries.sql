-- Example SQL queries for living-order workflows.

.headers on
.mode column

SELECT
    scenario_id,
    initial_value,
    setpoint,
    correction_rate,
    CASE
        WHEN correction_rate > 0 THEN log(2.0) / correction_rate
        ELSE NULL
    END AS half_recovery_time
FROM homeostasis_scenarios
ORDER BY half_recovery_time ASC;

SELECT
    condition_name,
    COUNT(*) AS n_observations,
    MIN(time) AS first_time,
    MAX(time) AS last_time,
    MIN(abundance) AS min_abundance,
    MAX(abundance) AS max_abundance
FROM growth_observations
GROUP BY condition_name
ORDER BY condition_name;

SELECT
    scenario_id,
    initial_abundance,
    growth_rate,
    carrying_capacity,
    time_end
FROM logistic_scenarios
ORDER BY carrying_capacity DESC;

SELECT
    scenario_id,
    state,
    setpoint,
    feedback_gain,
    state - setpoint AS deviation,
    feedback_gain * (setpoint - state) AS corrective_response
FROM feedback_scenarios
ORDER BY abs(corrective_response) DESC;

SELECT
    source AS node,
    COUNT(*) AS outgoing_edges,
    SUM(interaction_weight) AS outgoing_weight
FROM network_edges
GROUP BY source
ORDER BY outgoing_weight DESC;

SELECT
    interaction_type,
    COUNT(*) AS n_edges,
    AVG(interaction_weight) AS mean_weight
FROM network_edges
GROUP BY interaction_type
ORDER BY mean_weight DESC;

SELECT
    site_name,
    homeostatic_regulation,
    metabolic_throughput,
    structural_integration,
    developmental_coordination,
    information_continuity,
    ecological_relation,
    stress_penalty,
    0.17 * homeostatic_regulation +
    0.16 * metabolic_throughput +
    0.15 * structural_integration +
    0.13 * developmental_coordination +
    0.15 * information_continuity +
    0.14 * ecological_relation +
    0.10 * (1 - stress_penalty) AS living_order_score
FROM living_order_condition_sites
ORDER BY living_order_score DESC;

SELECT
    dataset_name,
    source_name,
    analytical_method,
    processing_step,
    uncertainty_notes
FROM provenance_records
ORDER BY recorded_at DESC;
