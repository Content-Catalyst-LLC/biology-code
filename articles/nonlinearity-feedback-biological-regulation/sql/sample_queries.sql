.headers on
.mode column

SELECT
    model_id,
    model_name,
    biological_domain,
    model_type,
    primary_use
FROM model_catalog
ORDER BY model_id;

SELECT
    scenario_id,
    vmax,
    k_half,
    vmax * 20.0 / (k_half + 20.0) AS response_at_20,
    vmax * 80.0 / (k_half + 80.0) AS response_at_80
FROM saturating_response_scenarios
ORDER BY scenario_id;

SELECT
    scenario_id,
    k_half,
    hill_coefficient
FROM hill_scenarios
ORDER BY hill_coefficient;

SELECT
    scenario_id,
    x0,
    set_point,
    k,
    dt,
    t_end
FROM negative_feedback_scenarios
ORDER BY k;

SELECT
    scenario_id,
    x0,
    alpha,
    beta,
    k_half,
    hill_coefficient
FROM positive_feedback_scenarios
ORDER BY x0;

SELECT
    scenario_id,
    delay,
    production_rate,
    feedback_strength
FROM delayed_feedback_scenarios
ORDER BY delay;

SELECT
    dataset_name,
    source_name,
    analytical_method,
    processing_step,
    uncertainty_notes
FROM provenance_records
ORDER BY recorded_at DESC;
