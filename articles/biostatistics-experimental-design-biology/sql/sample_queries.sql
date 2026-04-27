.headers on
.mode column

SELECT
    group_name,
    COUNT(*) AS n,
    AVG(measurement_value) AS mean_value,
    MIN(measurement_value) AS min_value,
    MAX(measurement_value) AS max_value
FROM two_group_measurements
GROUP BY group_name
ORDER BY group_name;

SELECT
    block_id,
    MAX(CASE WHEN treatment = 'treated' THEN response END) -
    MAX(CASE WHEN treatment = 'control' THEN response END) AS within_block_difference
FROM blocked_design
GROUP BY block_id
ORDER BY block_id;

SELECT
    temperature,
    nutrient,
    COUNT(*) AS n,
    AVG(response) AS mean_response,
    MIN(response) AS min_response,
    MAX(response) AS max_response
FROM factorial_design_observations
GROUP BY temperature, nutrient
ORDER BY temperature, nutrient;

SELECT
    treatment,
    biological_unit,
    COUNT(*) AS n_technical_replicates,
    AVG(response) AS unit_mean
FROM nested_replicates
GROUP BY treatment, biological_unit
ORDER BY treatment, biological_unit;

SELECT
    block_id,
    treatment,
    COUNT(*) AS n_wells
FROM assay_plate_layout
GROUP BY block_id, treatment
ORDER BY block_id, treatment;

SELECT
    dataset_name,
    source_name,
    analytical_method,
    processing_step,
    uncertainty_notes
FROM provenance_records
ORDER BY recorded_at DESC;
