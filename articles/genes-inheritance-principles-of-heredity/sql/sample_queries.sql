-- Example SQL queries for heredity workflows.

.headers on
.mode column

SELECT
    genotype,
    genotype_count
FROM genotype_counts
ORDER BY genotype;

SELECT
    SUM(genotype_count) AS n_individuals,
    (2.0 * SUM(CASE WHEN genotype = 'AA' THEN genotype_count ELSE 0 END) +
     SUM(CASE WHEN genotype = 'Aa' THEN genotype_count ELSE 0 END)) /
     (2.0 * SUM(genotype_count)) AS p,
    1.0 - (
     (2.0 * SUM(CASE WHEN genotype = 'AA' THEN genotype_count ELSE 0 END) +
     SUM(CASE WHEN genotype = 'Aa' THEN genotype_count ELSE 0 END)) /
     (2.0 * SUM(genotype_count))
    ) AS q
FROM genotype_counts;

SELECT
    test_name,
    category_name,
    observed_count,
    expected_ratio,
    SUM(observed_count) OVER (PARTITION BY test_name) * expected_ratio AS expected_count,
    ((observed_count - (SUM(observed_count) OVER (PARTITION BY test_name) * expected_ratio)) *
     (observed_count - (SUM(observed_count) OVER (PARTITION BY test_name) * expected_ratio))) /
     (SUM(observed_count) OVER (PARTITION BY test_name) * expected_ratio) AS chi_component
FROM inheritance_ratio_tests
ORDER BY test_name, category_name;

SELECT
    gamete,
    gamete_count,
    gamete_class,
    1.0 * gamete_count / (SELECT SUM(gamete_count) FROM recombination_observations) AS gamete_frequency
FROM recombination_observations
ORDER BY gamete;

SELECT
    SUM(CASE WHEN gamete_class = 'recombinant' THEN gamete_count ELSE 0 END) * 1.0 /
    SUM(gamete_count) AS recombination_fraction
FROM recombination_observations;

SELECT
    AVG(additive_genetic_value) AS mean_additive_genetic_value,
    AVG(environmental_effect) AS mean_environmental_effect,
    AVG(phenotype) AS mean_phenotype
FROM quantitative_trait_records;

SELECT
    site_name,
    standing_variation,
    inheritance_clarity,
    recombination_information,
    population_size,
    genotype_quality,
    environmental_context,
    inbreeding_risk,
    0.18 * standing_variation +
    0.14 * inheritance_clarity +
    0.12 * recombination_information +
    0.15 * population_size +
    0.15 * genotype_quality +
    0.14 * environmental_context +
    0.12 * (1 - inbreeding_risk) AS heredity_condition_score
FROM heredity_condition_sites
ORDER BY heredity_condition_score DESC;

SELECT
    dataset_name,
    source_name,
    analytical_method,
    processing_step,
    uncertainty_notes
FROM provenance_records
ORDER BY recorded_at DESC;
