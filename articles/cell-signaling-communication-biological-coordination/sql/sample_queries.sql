-- Example SQL queries for signaling workflows.

.headers on
.mode column

SELECT
    ligand_concentration,
    observed_response,
    ligand_concentration / (1.5 + ligand_concentration) AS receptor_occupancy
FROM receptor_response_observations
ORDER BY ligand_concentration;

SELECT
    time_min,
    signal_value
FROM signaling_decay_observations
ORDER BY time_min;

SELECT
    cell_context,
    AVG(activation_score) AS mean_activation,
    MAX(activation_score) AS max_activation,
    COUNT(*) AS n_observations
FROM pathway_activation_observations
GROUP BY cell_context
ORDER BY mean_activation DESC;

SELECT
    pathway,
    ligand,
    activation_score,
    cell_context
FROM pathway_activation_observations
ORDER BY activation_score DESC;

SELECT
    site_name,
    receptor_detection,
    transduction_integrity,
    second_messenger_capacity,
    feedback_control,
    response_specificity,
    context_integration,
    noise_risk,
    0.16 * receptor_detection +
    0.16 * transduction_integrity +
    0.14 * second_messenger_capacity +
    0.15 * feedback_control +
    0.14 * response_specificity +
    0.15 * context_integration +
    0.10 * (1 - noise_risk) AS signaling_condition_score
FROM signaling_condition_sites
ORDER BY signaling_condition_score DESC;

SELECT
    dataset_name,
    source_name,
    analytical_method,
    processing_step,
    uncertainty_notes
FROM provenance_records
ORDER BY recorded_at DESC;
