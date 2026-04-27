.headers on
.mode column

SELECT
    experiment_id,
    context,
    successes,
    trials,
    successes * 1.0 / trials AS estimate,
    sqrt((successes * 1.0 / trials) * (1.0 - successes * 1.0 / trials) / trials) AS standard_error
FROM binomial_trials
ORDER BY experiment_id;

SELECT
    scenario_id,
    alpha_prior,
    beta_prior,
    successes,
    trials,
    alpha_prior + successes AS alpha_posterior,
    beta_prior + trials - successes AS beta_posterior,
    (alpha_prior + successes) * 1.0 /
      (alpha_prior + beta_prior + trials) AS posterior_mean
FROM bayesian_priors
ORDER BY scenario_id;

SELECT
    group_name,
    COUNT(*) AS n_samples,
    AVG(measurement_value) AS mean_value,
    MIN(measurement_value) AS min_value,
    MAX(measurement_value) AS max_value
FROM biological_measurements
GROUP BY group_name
ORDER BY group_name;

SELECT
    scenario_id,
    sample_size_per_group,
    effect_size,
    sigma,
    alpha,
    n_sim
FROM power_scenarios
ORDER BY sample_size_per_group;

SELECT
    feature_id,
    p_value
FROM multiple_testing
ORDER BY p_value;

SELECT
    dataset_name,
    source_name,
    analytical_method,
    processing_step,
    uncertainty_notes
FROM provenance_records
ORDER BY recorded_at DESC;
