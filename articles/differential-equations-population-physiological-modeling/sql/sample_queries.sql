.headers on
.mode column

SELECT
    model_id,
    model_name,
    biological_domain,
    equation_type,
    primary_use
FROM model_catalog
ORDER BY model_id;

SELECT
    scenario_id,
    N0,
    r,
    K,
    dt,
    t_end
FROM logistic_scenarios
ORDER BY scenario_id;

SELECT
    scenario_id,
    beta,
    gamma,
    beta / gamma AS reproduction_parameter_ratio,
    S0,
    I0,
    R0
FROM sir_scenarios
ORDER BY reproduction_parameter_ratio DESC;

SELECT
    scenario_id,
    C0,
    elimination_rate,
    log(2.0) / elimination_rate AS half_life
FROM pharmacokinetic_scenarios
ORDER BY half_life DESC;

SELECT
    scenario_id,
    X0,
    S0,
    S_in,
    D,
    Y,
    mu_max,
    K_s
FROM chemostat_scenarios
ORDER BY scenario_id;

SELECT
    dataset_name,
    source_name,
    analytical_method,
    processing_step,
    uncertainty_notes
FROM provenance_records
ORDER BY recorded_at DESC;
