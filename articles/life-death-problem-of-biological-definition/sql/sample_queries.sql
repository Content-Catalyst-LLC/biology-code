-- Example SQL queries for life-definition workflows.

.headers on
.mode column

SELECT
    condition_name,
    COUNT(*) AS n_observations,
    MIN(time_h) AS first_time_h,
    MAX(time_h) AS last_time_h,
    MIN(live_cells) AS min_live_cells,
    MAX(live_cells) AS max_live_cells
FROM viability_observations
GROUP BY condition_name
ORDER BY condition_name;

SELECT
    scenario_id,
    dormant_initial,
    mortality_rate,
    reactivation_rate,
    time_end,
    dormant_initial * exp(-(mortality_rate + reactivation_rate) * time_end) AS expected_final_dormant
FROM dormancy_scenarios
ORDER BY expected_final_dormant DESC;

SELECT
    scenario_id,
    target_initial,
    infected_initial,
    virus_initial,
    beta,
    delta,
    production,
    clearance
FROM host_virus_scenarios
ORDER BY scenario_id;

SELECT
    criterion,
    weight
FROM life_criteria_weights
ORDER BY criterion;

SELECT
    case_id,
    organization,
    metabolism,
    autonomy,
    heredity,
    responsiveness,
    evolutionary_capacity,
    0.18 * organization +
    0.18 * metabolism +
    0.16 * autonomy +
    0.18 * heredity +
    0.12 * responsiveness +
    0.18 * evolutionary_capacity AS heuristic_life_score
FROM borderline_cases
ORDER BY heuristic_life_score DESC;

SELECT
    dataset_name,
    source_name,
    analytical_method,
    processing_step,
    uncertainty_notes
FROM provenance_records
ORDER BY recorded_at DESC;
