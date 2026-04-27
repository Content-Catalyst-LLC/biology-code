.headers on
.mode column

SELECT
    scenario,
    initial_population,
    growth_rate,
    carrying_capacity,
    dt,
    steps,
    noise_sd
FROM simulation_parameters
ORDER BY scenario;

SELECT
    sequence_id,
    sequence_length,
    ROUND(gc_content, 5) AS gc_content,
    ambiguous_bases
FROM sequences
ORDER BY sequence_id;

SELECT
    m.condition,
    COUNT(*) AS n_sequences,
    AVG(s.gc_content) AS mean_gc_content,
    SUM(s.ambiguous_bases) AS total_ambiguous_bases
FROM sequences s
JOIN sequence_metadata m
  ON s.sequence_id = m.sequence_id
GROUP BY m.condition;

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

SELECT
    check_name,
    passed,
    details
FROM validation_checks
ORDER BY check_id;
