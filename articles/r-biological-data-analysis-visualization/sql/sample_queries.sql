.headers on
.mode column

SELECT
    treatment,
    COUNT(value) AS n_valid_values,
    AVG(value) AS mean_value,
    MIN(value) AS min_value,
    MAX(value) AS max_value
FROM measurements
WHERE qc_flag = 'pass' AND value IS NOT NULL
GROUP BY treatment;

SELECT
    batch_id,
    qc_flag,
    COUNT(*) AS n_records
FROM measurements
GROUP BY batch_id, qc_flag
ORDER BY batch_id, qc_flag;

SELECT
    site,
    habitat,
    SUM(count) AS total_abundance,
    SUM(CASE WHEN count > 0 THEN 1 ELSE 0 END) AS richness
FROM species_counts
GROUP BY site, habitat
ORDER BY site;

SELECT
    dose,
    COUNT(*) AS n_measurements,
    AVG(response) AS mean_response
FROM dose_response
WHERE qc_flag = 'pass'
GROUP BY dose
ORDER BY dose;

SELECT
    step_id,
    input_artifact,
    operation,
    script,
    output_artifact
FROM provenance_manifest
ORDER BY step_id;

SELECT
    figure_name,
    source_script,
    input_data,
    output_path,
    figure_purpose
FROM figures
ORDER BY figure_id;
