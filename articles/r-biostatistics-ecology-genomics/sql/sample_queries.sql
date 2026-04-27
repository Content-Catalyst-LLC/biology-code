.headers on
.mode column

SELECT
    treatment,
    COUNT(*) AS n_samples,
    AVG(response) AS mean_response,
    MIN(response) AS min_response,
    MAX(response) AS max_response
FROM biostat_measurements
WHERE qc_flag = 'pass'
GROUP BY treatment;

SELECT
    batch,
    qc_flag,
    COUNT(*) AS n_records
FROM biostat_measurements
GROUP BY batch, qc_flag
ORDER BY batch, qc_flag;

SELECT
    site,
    habitat,
    SUM(count) AS total_abundance,
    SUM(CASE WHEN count > 0 THEN 1 ELSE 0 END) AS richness
FROM ecology_counts
GROUP BY site, habitat
ORDER BY site;

SELECT
    gene_id,
    SUM(raw_count) AS total_raw_count
FROM genomics_counts_long
GROUP BY gene_id
ORDER BY total_raw_count DESC;

SELECT
    m.condition,
    SUM(c.raw_count) AS condition_library_total
FROM genomics_counts_long c
JOIN genomics_metadata m
  ON c.sample_id = m.sample_id
GROUP BY m.condition;

SELECT
    step_id,
    operation,
    script,
    output_artifact
FROM provenance_manifest
ORDER BY step_id;
