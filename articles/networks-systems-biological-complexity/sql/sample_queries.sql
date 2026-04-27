.headers on
.mode column

SELECT
    COUNT(*) AS n_nodes
FROM biological_nodes;

SELECT
    COUNT(*) AS n_edges,
    AVG(weight) AS mean_weight,
    MIN(weight) AS min_weight,
    MAX(weight) AS max_weight
FROM biological_edges;

SELECT
    source_node AS node_id,
    COUNT(*) AS outgoing_or_source_edges
FROM biological_edges
GROUP BY source_node
ORDER BY outgoing_or_source_edges DESC;

SELECT
    module_hint,
    COUNT(*) AS n_edges,
    AVG(weight) AS mean_weight
FROM biological_edges
GROUP BY module_hint
ORDER BY n_edges DESC;

SELECT
    module_hint,
    COUNT(*) AS n_food_web_edges,
    AVG(weight) AS mean_weight
FROM food_web_edges
GROUP BY module_hint
ORDER BY n_food_web_edges DESC;

SELECT
    module_hint,
    COUNT(*) AS n_associations,
    AVG(association_strength) AS mean_association
FROM microbiome_associations
GROUP BY module_hint
ORDER BY n_associations DESC;

SELECT
    dataset_name,
    source_name,
    analytical_method,
    processing_step,
    uncertainty_notes
FROM provenance_records
ORDER BY recorded_at DESC;
