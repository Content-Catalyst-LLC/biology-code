-- Example SQL queries for mutation, variation, and novelty workflows.

.headers on
.mode column

SELECT
    mutation_class,
    mutation_count,
    1.0 * mutation_count / (SELECT SUM(mutation_count) FROM mutation_spectrum) AS spectrum_fraction
FROM mutation_spectrum
ORDER BY spectrum_fraction DESC;

SELECT
    taxon_name,
    length(sequence_text) AS sequence_length
FROM aligned_sequences
ORDER BY taxon_name;

SELECT
    site_name,
    derived_count,
    n_chromosomes,
    1.0 * derived_count / n_chromosomes AS derived_frequency,
    2.0 * (1.0 * derived_count / n_chromosomes) * (1.0 - (1.0 * derived_count / n_chromosomes)) AS pi_site
FROM genotype_site_summary
ORDER BY site_id;

SELECT
    COUNT(*) AS n_sites,
    SUM(CASE WHEN derived_count > 0 AND derived_count < n_chromosomes THEN 1 ELSE 0 END) AS segregating_sites,
    AVG(2.0 * (1.0 * derived_count / n_chromosomes) * (1.0 - (1.0 * derived_count / n_chromosomes))) AS nucleotide_diversity
FROM genotype_site_summary;

SELECT
    variant_id,
    variant_type,
    size_bp,
    overlaps_gene,
    overlaps_regulatory_region,
    population_frequency,
    1.0 - population_frequency AS rarity_score
FROM structural_variants
ORDER BY population_frequency ASC;

SELECT
    site_name,
    mutation_supply,
    standing_variation,
    recombination_potential,
    regulatory_flexibility,
    developmental_modularity,
    ecological_opportunity,
    constraint_risk,
    0.15 * mutation_supply +
    0.17 * standing_variation +
    0.14 * recombination_potential +
    0.15 * regulatory_flexibility +
    0.15 * developmental_modularity +
    0.14 * ecological_opportunity +
    0.10 * (1 - constraint_risk) AS novelty_condition_score
FROM novelty_condition_sites
ORDER BY novelty_condition_score DESC;

SELECT
    dataset_name,
    source_name,
    analytical_method,
    processing_step,
    uncertainty_notes
FROM provenance_records
ORDER BY recorded_at DESC;
