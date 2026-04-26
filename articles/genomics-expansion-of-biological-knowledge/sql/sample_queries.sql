-- Example SQL queries for genomics workflows.

.headers on
.mode column

SELECT
    sample_group,
    COUNT(*) AS n_samples
FROM sample_metadata
GROUP BY sample_group;

SELECT
    gene_name,
    AVG(CASE WHEN sample_group = 'control' THEN count_value END) AS mean_control,
    AVG(CASE WHEN sample_group = 'treated' THEN count_value END) AS mean_treated,
    log((AVG(CASE WHEN sample_group = 'treated' THEN count_value END) + 1.0) /
        (AVG(CASE WHEN sample_group = 'control' THEN count_value END) + 1.0)) / log(2.0) AS log2_fc
FROM expression_observations
JOIN sample_metadata USING (sample_id)
GROUP BY gene_name
ORDER BY ABS(log2_fc) DESC;

SELECT
    locus_id,
    1.0 * alt_count_pop1 / n_chrom_pop1 AS p1,
    1.0 * alt_count_pop2 / n_chrom_pop2 AS p2,
    2.0 * (1.0 * alt_count_pop1 / n_chrom_pop1) * (1.0 - (1.0 * alt_count_pop1 / n_chrom_pop1)) AS he_pop1,
    2.0 * (1.0 * alt_count_pop2 / n_chrom_pop2) * (1.0 - (1.0 * alt_count_pop2 / n_chrom_pop2)) AS he_pop2,
    missing_rate
FROM variant_site_summary
ORDER BY locus_id;

SELECT
    taxon_name,
    length(sequence_text) AS sequence_length
FROM aligned_sequences
ORDER BY taxon_name;

SELECT
    taxon_name,
    reads,
    1.0 * reads / (SELECT SUM(reads) FROM metagenomic_profile) AS relative_abundance,
    carbon_cycle_genes,
    nitrogen_cycle_genes,
    stress_response_genes
FROM metagenomic_profile
ORDER BY relative_abundance DESC;

SELECT
    site_name,
    assembly_quality,
    annotation_depth,
    variant_quality,
    expression_signal,
    population_representation,
    provenance_quality,
    bias_risk,
    0.16 * assembly_quality +
    0.16 * annotation_depth +
    0.16 * variant_quality +
    0.14 * expression_signal +
    0.14 * population_representation +
    0.14 * provenance_quality +
    0.10 * (1 - bias_risk) AS genomic_condition_score
FROM genomic_condition_sites
ORDER BY genomic_condition_score DESC;

SELECT
    dataset_name,
    source_name,
    analytical_method,
    processing_step,
    uncertainty_notes
FROM provenance_records
ORDER BY recorded_at DESC;
