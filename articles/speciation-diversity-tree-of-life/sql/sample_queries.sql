-- Example SQL queries for speciation, diversity, and tree-of-life workflows.

.headers on
.mode column

SELECT
    scenario_name,
    generations,
    loci,
    population_1_size,
    population_2_size,
    migration_12,
    migration_21,
    selection_sd
FROM divergence_scenarios
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
    site_name,
    allele_divergence,
    reproductive_isolation,
    ecological_difference,
    phylogenetic_resolution,
    gene_flow_risk,
    lineage_distinctiveness,
    0.20 * allele_divergence +
    0.20 * reproductive_isolation +
    0.18 * ecological_difference +
    0.16 * phylogenetic_resolution +
    0.14 * (1 - gene_flow_risk) +
    0.12 * lineage_distinctiveness AS speciation_condition_score
FROM speciation_condition_sites
ORDER BY speciation_condition_score DESC;

SELECT
    dataset_name,
    source_name,
    analytical_method,
    processing_step,
    uncertainty_notes
FROM provenance_records
ORDER BY recorded_at DESC;
