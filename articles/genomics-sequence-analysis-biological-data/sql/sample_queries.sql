.headers on
.mode column

SELECT
    sequence_id,
    sequence_length,
    ROUND(gc_content, 5) AS gc_content,
    ambiguous_bases
FROM sequence_records
ORDER BY sequence_id;

SELECT
    m.condition,
    COUNT(*) AS n_sequences,
    AVG(s.gc_content) AS mean_gc_content,
    SUM(s.ambiguous_bases) AS total_ambiguous_bases
FROM sequence_records s
JOIN sequence_metadata m
  ON s.sequence_id = m.sequence_id
GROUP BY m.condition;

SELECT
    read_id,
    read_length,
    ROUND(mean_phred, 2) AS mean_phred,
    ambiguous_bases
FROM fastq_reads
ORDER BY read_id;

SELECT
    variant_id,
    chromosome,
    position,
    reference,
    alternate,
    read_depth,
    alternate_depth,
    ROUND(CAST(alternate_depth AS REAL) / read_depth, 5) AS variant_allele_frequency
FROM variants
ORDER BY chromosome, position;

SELECT
    step_id,
    operation,
    input_artifact,
    script,
    output_artifact
FROM workflow_steps
ORDER BY step_id;

SELECT
    artifact_role,
    COUNT(*) AS n_artifacts
FROM artifacts
GROUP BY artifact_role
ORDER BY n_artifacts DESC;
