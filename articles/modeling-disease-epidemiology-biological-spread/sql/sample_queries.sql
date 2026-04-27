.headers on
.mode column

SELECT
    scenario,
    beta,
    sigma,
    gamma,
    ROUND(beta / NULLIF(gamma, 0), 4) AS simple_r0
FROM model_scenarios
ORDER BY scenario;

SELECT
    day,
    reported_cases,
    estimated_reporting_completeness,
    ROUND(reported_cases / estimated_reporting_completeness, 2) AS adjusted_cases
FROM incidence
ORDER BY day;

SELECT
    week,
    observed_cases,
    predicted_cases,
    observed_cases - predicted_cases AS error
FROM forecast_validation
ORDER BY week;

SELECT
    scenario,
    initial_cases,
    reproduction_mean,
    generations,
    random_seed
FROM branching_parameters
ORDER BY scenario;

SELECT
    step_id,
    operation,
    input_artifact,
    script,
    output_artifact
FROM workflow_steps
ORDER BY step_id;

SELECT
    artifact_role,
    COUNT(*) AS n_artifacts
FROM artifacts
GROUP BY artifact_role
ORDER BY n_artifacts DESC;
