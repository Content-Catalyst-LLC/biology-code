.headers on
.mode column

SELECT
    node_id,
    node_type,
    pathway,
    description
FROM nodes
ORDER BY node_id;

SELECT
    source,
    target,
    interaction,
    sign,
    weight,
    evidence_score
FROM interactions
ORDER BY source, target;

SELECT
    pathway,
    ROUND(AVG(z_score), 5) AS pathway_activity,
    COUNT(*) AS n_measured_genes
FROM pathway_gene_sets p
JOIN expression_measurements e
  ON p.gene = e.gene
GROUP BY pathway
ORDER BY pathway;

SELECT
    metabolite,
    glucose_import * 8 + glycolysis * 8 + biomass * 4 AS mass_balance_residual
FROM stoichiometry
ORDER BY metabolite;

SELECT
    node_id,
    observed_response,
    predicted_response,
    observed_response - predicted_response AS error
FROM validation_observations
ORDER BY node_id;

SELECT
    step_id,
    operation,
    input_artifact,
    script,
    output_artifact
FROM workflow_steps
ORDER BY step_id;
