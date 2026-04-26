-- Example SQL queries for natural selection workflows.

.headers on
.mode column

SELECT
    scenario_name,
    initial_allele_frequency AS p,
    1 - initial_allele_frequency AS q,
    fitness_AA,
    fitness_Aa,
    fitness_aa,
    initial_allele_frequency * initial_allele_frequency * fitness_AA +
    2 * initial_allele_frequency * (1 - initial_allele_frequency) * fitness_Aa +
    (1 - initial_allele_frequency) * (1 - initial_allele_frequency) * fitness_aa AS mean_fitness
FROM selection_scenarios
ORDER BY scenario_id;

SELECT
    individual_id,
    trait_value
FROM trait_observations
ORDER BY trait_value;

SELECT
    environment_name,
    fitness_AA,
    fitness_Aa,
    fitness_aa
FROM variable_environment_scenarios
ORDER BY environment_id;

SELECT
    time_value,
    allele_frequency
FROM allele_frequency_timeseries
ORDER BY time_value;

SELECT
    site_name,
    standing_variation,
    selection_strength,
    environmental_match,
    demographic_stability,
    gene_flow_support,
    constraint_risk,
    0.18 * standing_variation +
    0.18 * selection_strength +
    0.18 * environmental_match +
    0.16 * demographic_stability +
    0.14 * gene_flow_support +
    0.16 * (1 - constraint_risk) AS selection_condition_score
FROM selection_condition_sites
ORDER BY selection_condition_score DESC;

SELECT
    dataset_name,
    source_name,
    analytical_method,
    processing_step,
    uncertainty_notes
FROM provenance_records
ORDER BY recorded_at DESC;
