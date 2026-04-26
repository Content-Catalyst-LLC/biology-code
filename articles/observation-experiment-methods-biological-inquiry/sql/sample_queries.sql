.headers on
.mode column

SELECT
    condition_name,
    COUNT(*) AS n_observations,
    MIN(time_h) AS first_time_h,
    MAX(time_h) AS last_time_h,
    MIN(abundance) AS min_abundance,
    MAX(abundance) AS max_abundance
FROM growth_observations
GROUP BY condition_name
ORDER BY condition_name;

SELECT
    assay_id,
    true_positive * 1.0 / (true_positive + false_negative) AS sensitivity,
    true_negative * 1.0 / (true_negative + false_positive) AS specificity,
    true_positive * 1.0 / (true_positive + false_positive) AS positive_predictive_value,
    true_negative * 1.0 / (true_negative + false_negative) AS negative_predictive_value,
    (true_positive + true_negative) * 1.0 /
      (true_positive + false_negative + true_negative + false_positive) AS accuracy
FROM assay_validation
ORDER BY accuracy DESC;

SELECT
    condition_name,
    COUNT(*) AS n_cells,
    AVG(area_um2) AS mean_area_um2,
    AVG(mean_intensity) AS mean_intensity,
    AVG(roundness) AS mean_roundness
FROM imaging_features
GROUP BY condition_name
ORDER BY condition_name;

SELECT
    experiment_id,
    0.30 * signal_strength +
    0.30 * reproducibility +
    0.25 * control_separation -
    0.15 * noise_penalty AS signal_quality_score
FROM experimental_signal_scores
ORDER BY signal_quality_score DESC;

SELECT
    dataset_name,
    source_name,
    analytical_method,
    processing_step,
    uncertainty_notes
FROM provenance_records
ORDER BY recorded_at DESC;
