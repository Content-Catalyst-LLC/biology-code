.headers on
.mode column

SELECT
    model_id,
    model_name,
    biological_domain,
    mathematical_structure,
    primary_use
FROM model_catalog
ORDER BY model_id;

SELECT
    scenario_id,
    initial_population,
    growth_rate,
    carrying_capacity,
    time_end,
    CASE
        WHEN growth_rate > 0 THEN log(2.0) / growth_rate
        ELSE NULL
    END AS initial_doubling_time
FROM logistic_scenarios
ORDER BY scenario_id;

SELECT
    scenario_id,
    beta,
    gamma,
    beta / gamma AS R0,
    susceptible0,
    infected0,
    recovered0
FROM sir_scenarios
ORDER BY R0 DESC;

SELECT
    scenario_id,
    substrate,
    vmax,
    km,
    vmax * substrate / (km + substrate) AS velocity
FROM enzyme_kinetics
ORDER BY scenario_id, substrate;

SELECT
    source AS node,
    COUNT(*) AS out_degree,
    SUM(weight) AS outgoing_weight
FROM network_edges
GROUP BY source
ORDER BY out_degree DESC, node;

SELECT
    target AS node,
    COUNT(*) AS in_degree,
    SUM(weight) AS incoming_weight
FROM network_edges
GROUP BY target
ORDER BY in_degree DESC, node;

SELECT
    dataset_name,
    source_name,
    analytical_method,
    processing_step,
    uncertainty_notes
FROM provenance_records
ORDER BY recorded_at DESC;
