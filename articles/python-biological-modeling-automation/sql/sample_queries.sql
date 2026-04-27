.headers on
.mode column

SELECT
    scenario,
    initial_population,
    growth_rate,
    carrying_capacity,
    dt,
    steps
FROM logistic_parameters
ORDER BY scenario;

SELECT
    scenario,
    initial_a,
    initial_b,
    k_ab,
    k_ba,
    k_clear,
    dt,
    steps
FROM compartment_parameters
ORDER BY scenario;

SELECT
    parameter,
    lower_bound,
    upper_bound,
    unit,
    description
FROM parameter_rules
ORDER BY parameter;

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

SELECT
    operation,
    input_artifact,
    output_artifact,
    script
FROM provenance_records
ORDER BY provenance_id;
