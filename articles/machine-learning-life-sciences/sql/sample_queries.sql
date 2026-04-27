.mode column
.headers on

SELECT
    condition,
    batch_id,
    COUNT(*) AS n_samples
FROM biological_samples
GROUP BY condition, batch_id
ORDER BY batch_id, condition;

SELECT
    s.sample_id,
    s.condition,
    s.batch_id,
    f.immune_score,
    f.metabolic_score,
    f.morphology_score,
    f.stress_response_score
FROM biological_samples AS s
JOIN biomarker_features AS f
    ON s.sample_id = f.sample_id
ORDER BY s.sample_id;

SELECT
    artifact_name,
    artifact_type,
    source_description
FROM data_provenance
ORDER BY artifact_name;
