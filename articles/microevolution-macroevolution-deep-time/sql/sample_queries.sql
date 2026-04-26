-- Example SQL queries for microevolution, macroevolution, and deep time workflows.

.headers on
.mode column

SELECT
    scenario_name,
    initial_allele_frequency,
    1 - initial_allele_frequency AS q,
    initial_allele_frequency * initial_allele_frequency AS expected_AA,
    2 * initial_allele_frequency * (1 - initial_allele_frequency) AS expected_Aa,
    (1 - initial_allele_frequency) * (1 - initial_allele_frequency) AS expected_aa
FROM population_scenarios
ORDER BY scenario_id;

SELECT
    clade_name,
    originations,
    extinctions,
    interval_myr,
    originations / interval_myr AS lambda_rate,
    extinctions / interval_myr AS mu_rate,
    (originations / interval_myr) - (extinctions / interval_myr) AS net_diversification,
    (originations / interval_myr) + (extinctions / interval_myr) AS turnover
FROM clade_turnover
ORDER BY net_diversification DESC;

SELECT
    lineage_name,
    length(sequence_text) AS sequence_length
FROM aligned_sequences
ORDER BY lineage_name;

SELECT
    scenario_name,
    initial_lineages,
    intervals,
    lambda_rate,
    mu_rate,
    lambda_rate - mu_rate AS expected_net_rate
FROM birth_death_scenarios
ORDER BY expected_net_rate DESC;

SELECT
    site_name,
    population_variation,
    lineage_distinctiveness,
    fossil_record_strength,
    phylogenetic_resolution,
    extinction_pressure,
    adaptive_capacity
FROM evolutionary_scale_sites
ORDER BY site_id;

SELECT
    dataset_name,
    source_name,
    analytical_method,
    processing_step,
    uncertainty_notes
FROM provenance_records
ORDER BY recorded_at DESC;
