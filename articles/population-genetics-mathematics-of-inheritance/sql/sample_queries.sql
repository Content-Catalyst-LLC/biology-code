-- Example SQL queries for population genetics workflows.

.headers on
.mode column

SELECT
    scenario_name,
    initial_allele_frequency AS p,
    1 - initial_allele_frequency AS q,
    initial_allele_frequency * initial_allele_frequency AS expected_AA,
    2 * initial_allele_frequency * (1 - initial_allele_frequency) AS expected_Aa,
    (1 - initial_allele_frequency) * (1 - initial_allele_frequency) AS expected_aa
FROM population_genetics_scenarios
ORDER BY scenario_id;

SELECT
    locus_name,
    count(*) AS n,
    sum(CASE WHEN genotype_code = 2 THEN 1 ELSE 0 END) AS obs_AA,
    sum(CASE WHEN genotype_code = 1 THEN 1 ELSE 0 END) AS obs_Aa,
    sum(CASE WHEN genotype_code = 0 THEN 1 ELSE 0 END) AS obs_aa,
    (
        2.0 * sum(CASE WHEN genotype_code = 2 THEN 1 ELSE 0 END) +
        sum(CASE WHEN genotype_code = 1 THEN 1 ELSE 0 END)
    ) / (2.0 * count(*)) AS allele_frequency
FROM genotype_observations
GROUP BY locus_name
ORDER BY locus_name;

SELECT
    locus,
    avg(allele_frequency) AS pbar,
    avg(2 * allele_frequency * (1 - allele_frequency)) AS HS,
    2 * avg(allele_frequency) * (1 - avg(allele_frequency)) AS HT
FROM multipop_allele_frequencies
GROUP BY locus
ORDER BY locus;

SELECT
    scenario_name,
    p1_initial,
    p2_initial,
    abs(p1_initial - p2_initial) AS initial_delta_p,
    migration_12,
    migration_21,
    selection_1,
    selection_2
FROM migration_selection_scenarios
ORDER BY scenario_id;

SELECT
    site_name,
    heterozygosity,
    allelic_richness,
    gene_flow,
    fragmentation_pressure,
    bottleneck_risk,
    adaptive_capacity,
    0.18 * heterozygosity +
    0.18 * allelic_richness +
    0.16 * gene_flow +
    0.16 * (1 - fragmentation_pressure) +
    0.16 * (1 - bottleneck_risk) +
    0.16 * adaptive_capacity AS population_condition_score
FROM population_condition_sites
ORDER BY population_condition_score DESC;

SELECT
    dataset_name,
    source_name,
    analytical_method,
    processing_step,
    uncertainty_notes
FROM provenance_records
ORDER BY recorded_at DESC;
