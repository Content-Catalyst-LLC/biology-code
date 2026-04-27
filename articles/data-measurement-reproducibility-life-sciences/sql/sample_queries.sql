.headers on
.mode column

SELECT
    COUNT(*) AS n_measurements,
    SUM(CASE WHEN measurement_value IS NULL THEN 1 ELSE 0 END) AS n_missing,
    1.0 - CAST(SUM(CASE WHEN measurement_value IS NULL THEN 1 ELSE 0 END) AS REAL) / COUNT(*) AS completeness_rate
FROM measurements;

SELECT
    qc_flag,
    COUNT(*) AS n_records,
    CAST(COUNT(*) AS REAL) / (SELECT COUNT(*) FROM measurements) AS flag_fraction
FROM measurements
GROUP BY qc_flag
ORDER BY qc_flag;

SELECT
    batch_id,
    qc_flag,
    COUNT(*) AS n_records
FROM measurements
GROUP BY batch_id, qc_flag
ORDER BY batch_id, qc_flag;

SELECT
    component_name,
    standard_uncertainty,
    unit
FROM uncertainty_components
ORDER BY component_name;

SELECT
    SQRT(SUM(standard_uncertainty * standard_uncertainty)) AS combined_standard_uncertainty,
    2.0 * SQRT(SUM(standard_uncertainty * standard_uncertainty)) AS expanded_uncertainty
FROM uncertainty_components;

SELECT
    artifact_role,
    COUNT(*) AS n_artifacts
FROM artifacts
GROUP BY artifact_role
ORDER BY n_artifacts DESC;

SELECT
    step_id,
    input_artifact,
    operation,
    output_artifact,
    responsible_role
FROM provenance_steps
ORDER BY step_id;

SELECT
    workflow_name,
    input_artifact,
    output_artifact,
    run_status,
    run_timestamp
FROM workflow_runs
ORDER BY run_timestamp DESC;
