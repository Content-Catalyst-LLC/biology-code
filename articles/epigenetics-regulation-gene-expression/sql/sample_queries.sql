-- Example SQL queries for epigenetics, regulation, and gene-expression workflows.

.headers on
.mode column

SELECT
    time_h,
    expression_value
FROM expression_timecourse
ORDER BY time_h;

SELECT
    locus_name,
    methylated_count,
    unmethylated_count,
    1.0 * methylated_count / (methylated_count + unmethylated_count) AS methylation_fraction
FROM methylation_counts
ORDER BY locus_name;

SELECT
    gene_name,
    control_expr,
    treated_expr,
    log((treated_expr + 0.000001) / (control_expr + 0.000001)) / log(2) AS log2fc_expr,
    control_access,
    treated_access,
    treated_access - control_access AS delta_access
FROM expression_accessibility
ORDER BY log2fc_expr DESC;

SELECT
    scenario_name,
    kon,
    koff,
    kon / (kon + koff) AS steady_state_p_on,
    alpha_on,
    alpha_off,
    beta
FROM regulatory_scenarios
ORDER BY scenario_id;

SELECT
    state_name,
    stem_like,
    primed,
    differentiated
FROM cell_state_transition_matrix
ORDER BY row_id;

SELECT
    site_name,
    expression_stability,
    accessibility_signal,
    methylation_quality,
    state_memory,
    environmental_responsiveness,
    batch_risk,
    0.18 * expression_stability +
    0.18 * accessibility_signal +
    0.16 * methylation_quality +
    0.16 * state_memory +
    0.16 * environmental_responsiveness +
    0.16 * (1 - batch_risk) AS epigenetic_condition_score
FROM epigenetic_condition_sites
ORDER BY epigenetic_condition_score DESC;

SELECT
    dataset_name,
    source_name,
    analytical_method,
    processing_step,
    uncertainty_notes
FROM provenance_records
ORDER BY recorded_at DESC;
