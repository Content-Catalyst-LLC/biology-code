-- Example SQL queries for molecular information-flow workflows.

.headers on
.mode column

SELECT
    sample_name,
    molecule_type,
    length(sequence_text) AS sequence_length
FROM sequence_records
ORDER BY sample_name;

SELECT
    time_h,
    expression_value
FROM transcript_decay_observations
ORDER BY time_h;

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
    codon,
    amino_acid,
    codon_count,
    1.0 * codon_count / (SELECT SUM(codon_count) FROM codon_counts) AS codon_fraction
FROM codon_counts
ORDER BY codon_count DESC, codon;

SELECT
    experiment,
    observed_mutations,
    genomes_surveyed,
    sites_surveyed,
    generations,
    1.0 * observed_mutations / (genomes_surveyed * sites_surveyed * generations) AS mutation_rate
FROM mutation_observations
ORDER BY mutation_rate DESC;

SELECT
    site_name,
    replication_fidelity,
    transcription_signal,
    rna_processing,
    translation_support,
    repair_capacity,
    regulatory_context,
    expression_noise_risk,
    0.16 * replication_fidelity +
    0.15 * transcription_signal +
    0.14 * rna_processing +
    0.14 * translation_support +
    0.16 * repair_capacity +
    0.15 * regulatory_context +
    0.10 * (1 - expression_noise_risk) AS molecular_flow_score
FROM molecular_flow_condition_sites
ORDER BY molecular_flow_score DESC;

SELECT
    dataset_name,
    source_name,
    analytical_method,
    processing_step,
    uncertainty_notes
FROM provenance_records
ORDER BY recorded_at DESC;
