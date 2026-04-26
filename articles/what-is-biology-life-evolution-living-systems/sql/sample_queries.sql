.headers on
.mode column

SELECT
    level_name,
    example,
    core_question,
    related_fields
FROM biological_levels
ORDER BY level_id;

SELECT
    scenario,
    COUNT(*) AS n_observations,
    MIN(time) AS first_time,
    MAX(time) AS last_time,
    MIN(population) AS min_population,
    MAX(population) AS max_population
FROM growth_observations
GROUP BY scenario
ORDER BY scenario;

SELECT
    case_id,
    allele_frequency_p AS p,
    1.0 - allele_frequency_p AS q,
    allele_frequency_p * allele_frequency_p AS expected_AA,
    2.0 * allele_frequency_p * (1.0 - allele_frequency_p) AS expected_Aa,
    (1.0 - allele_frequency_p) * (1.0 - allele_frequency_p) AS expected_aa
FROM hardy_weinberg_cases
ORDER BY case_id;

SELECT
    site_id,
    SUM(abundance) AS total_abundance,
    COUNT(CASE WHEN abundance > 0 THEN 1 END) AS richness
FROM biodiversity_counts
GROUP BY site_id
ORDER BY total_abundance DESC;

SELECT
    sequence_id,
    length(sequence) AS sequence_length
FROM sequences
ORDER BY sequence_id;

SELECT
    dataset_name,
    source_name,
    analytical_method,
    processing_step,
    uncertainty_notes
FROM provenance_records
ORDER BY recorded_at DESC;
