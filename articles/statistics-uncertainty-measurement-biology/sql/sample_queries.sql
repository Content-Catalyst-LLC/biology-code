.headers on
.mode column

SELECT
    group_name,
    COUNT(*) AS n,
    AVG(measurement_value) AS mean_value,
    MIN(measurement_value) AS min_value,
    MAX(measurement_value) AS max_value
FROM measurements
GROUP BY group_name
ORDER BY group_name;

SELECT
    category,
    COUNT(*) AS n_components,
    sqrt(SUM(standard_uncertainty * standard_uncertainty)) AS combined_standard_uncertainty
FROM uncertainty_components
GROUP BY category
ORDER BY category;

SELECT
    sqrt(SUM(standard_uncertainty * standard_uncertainty)) AS combined_standard_uncertainty,
    2.0 * sqrt(SUM(standard_uncertainty * standard_uncertainty)) AS expanded_uncertainty
FROM uncertainty_components;

SELECT
    standard_id,
    concentration,
    response
FROM calibration_standards
ORDER BY concentration;

SELECT
    biological_unit,
    COUNT(*) AS n_technical_replicates,
    AVG(measurement) AS unit_mean,
    MIN(measurement) AS min_measurement,
    MAX(measurement) AS max_measurement
FROM biological_technical_replicates
GROUP BY biological_unit
ORDER BY biological_unit;

SELECT
    AVG(control_low) AS mean_control_low,
    AVG(control_high) AS mean_control_high,
    AVG(blank_response) AS mean_blank,
    AVG(positive_control) AS mean_positive_control
FROM assay_qc;

SELECT
    dataset_name,
    source_name,
    analytical_method,
    processing_step,
    uncertainty_notes
FROM provenance_records
ORDER BY recorded_at DESC;
