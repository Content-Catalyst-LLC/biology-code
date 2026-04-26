-- Example SQL queries for evolution and history-of-life workflows.

.headers on
.mode column

SELECT
    scenario_name,
    initial_allele_frequency AS p,
    1 - initial_allele_frequency AS q,
    initial_allele_frequency * initial_allele_frequency AS expected_AA,
    2 * initial_allele_frequency * (1 - initial_allele_frequency) AS expected_Aa,
    (1 - initial_allele_frequency) * (1 - initial_allele_frequency) AS expected_aa
FROM evolutionary_scenarios
ORDER BY scenario_id;

SELECT
    taxon_name,
    length(sequence_text) AS sequence_length
FROM aligned_sequences
ORDER BY taxon_name;

SELECT
    scenario_name,
    initial_richness,
    lambda_rate,
    mu_rate,
    lambda_rate - mu_rate AS net_diversification,
    lambda_rate + mu_rate AS turnover
FROM birth_death_scenarios
ORDER BY net_diversification DESC;

SELECT
    transition_name,
    approximate_context,
    biological_significance
FROM major_transitions
ORDER BY transition_id;

SELECT
    site_name,
    standing_variation,
    phylogenetic_signal,
    fossil_record_strength,
    environmental_change,
    extinction_pressure,
    adaptive_capacity,
    0.17 * standing_variation +
    0.17 * phylogenetic_signal +
    0.16 * fossil_record_strength +
    0.16 * (1 - environmental_change) +
    0.17 * (1 - extinction_pressure) +
    0.17 * adaptive_capacity AS evolutionary_condition_score
FROM evolutionary_condition_sites
ORDER BY evolutionary_condition_score DESC;

SELECT
    dataset_name,
    source_name,
    analytical_method,
    processing_step,
    uncertainty_notes
FROM provenance_records
ORDER BY recorded_at DESC;
