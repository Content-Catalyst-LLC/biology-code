-- Example SQL queries for developmental-biology workflows.

.headers on
.mode column

SELECT
    time_h,
    cells
FROM developmental_growth
ORDER BY time_h;

SELECT
    scenario_name,
    progenitor_initial,
    k1,
    k2,
    k1 + k2 AS total_commitment_rate,
    k1 / (k1 + k2) AS lineage_1_fraction
FROM lineage_scenarios
ORDER BY scenario_id;

SELECT
    position,
    morphogen,
    fate
FROM morphogen_gradient
ORDER BY position;

SELECT
    fate,
    count(*) AS n_positions,
    min(position) AS min_position,
    max(position) AS max_position
FROM morphogen_gradient
GROUP BY fate
ORDER BY fate;

SELECT
    state_name,
    progenitor,
    transitional,
    lineage_A,
    lineage_B
FROM state_transition_matrix
ORDER BY row_id;

SELECT
    site_name,
    growth_coherence,
    differentiation_signal,
    patterning_signal,
    morphogenesis_quality,
    environmental_stability,
    perturbation_risk,
    0.18 * growth_coherence +
    0.18 * differentiation_signal +
    0.16 * patterning_signal +
    0.16 * morphogenesis_quality +
    0.16 * environmental_stability +
    0.16 * (1 - perturbation_risk) AS developmental_condition_score
FROM developmental_condition_sites
ORDER BY developmental_condition_score DESC;

SELECT
    dataset_name,
    source_name,
    analytical_method,
    processing_step,
    uncertainty_notes
FROM provenance_records
ORDER BY recorded_at DESC;
