.mode column
.headers on

SELECT
    species,
    treatment,
    COUNT(*) AS n_samples,
    ROUND(AVG(response_value), 3) AS mean_response
FROM biological_samples
GROUP BY species, treatment
ORDER BY species, treatment;

SELECT
    step_id,
    step_name,
    notebook_section,
    output_artifact
FROM workflow_steps
ORDER BY step_id;

SELECT
    notebook_name,
    kernel,
    clean_run,
    failed_cells,
    executed_cells
FROM notebook_runs;

SELECT
    artifact_name,
    artifact_type,
    relative_path
FROM notebook_artifacts
ORDER BY artifact_name;
