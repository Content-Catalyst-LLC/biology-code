-- Example SQL queries for cell-theory workflows.

.headers on
.mode column

SELECT
    condition_name,
    COUNT(*) AS n_observations,
    MIN(time_h) AS first_time_h,
    MAX(time_h) AS last_time_h,
    MIN(cells) AS min_cells,
    MAX(cells) AS max_cells
FROM cell_counts
GROUP BY condition_name
ORDER BY condition_name;

SELECT
    scenario_id,
    initial_count,
    growth_rate,
    carrying_capacity,
    time_end,
    CASE
        WHEN growth_rate > 0 THEN log(2.0) / growth_rate
        ELSE NULL
    END AS initial_doubling_time_h
FROM logistic_scenarios
ORDER BY initial_doubling_time_h ASC;

SELECT
    condition_name,
    COUNT(*) AS n_observations,
    MIN(time_h) AS first_time_h,
    MAX(time_h) AS last_time_h,
    MIN(viable_cells) AS min_viable_cells,
    MAX(viable_cells) AS max_viable_cells
FROM viability_observations
GROUP BY condition_name
ORDER BY condition_name;

SELECT
    scenario_id,
    diffusion_coefficient_cm2_s,
    concentration_inside,
    concentration_outside,
    distance_cm,
    (concentration_outside - concentration_inside) / distance_cm AS concentration_gradient,
    -diffusion_coefficient_cm2_s * ((concentration_outside - concentration_inside) / distance_cm) AS membrane_flux
FROM membrane_gradients
ORDER BY membrane_flux DESC;

SELECT
    scenario_id,
    g1_initial,
    s_initial,
    g2m_initial,
    k1,
    k2,
    km
FROM cell_cycle_scenarios
ORDER BY scenario_id;

SELECT
    condition_name,
    AVG(area_um2) AS mean_area_um2,
    AVG(nuclear_area_um2) AS mean_nuclear_area_um2,
    AVG(mean_intensity) AS mean_intensity,
    AVG(roundness) AS mean_roundness,
    COUNT(*) AS n_cells
FROM imaging_features
GROUP BY condition_name
ORDER BY condition_name;

SELECT
    condition_id,
    membrane_integrity,
    metabolic_activity,
    proliferation_capacity,
    genomic_stability,
    organelle_function,
    stress_penalty,
    0.18 * membrane_integrity +
    0.22 * metabolic_activity +
    0.18 * proliferation_capacity +
    0.17 * genomic_stability +
    0.15 * organelle_function +
    0.10 * (1 - stress_penalty) AS cell_condition_score
FROM cell_condition_sites
ORDER BY cell_condition_score DESC;

SELECT
    dataset_name,
    source_name,
    analytical_method,
    processing_step,
    uncertainty_notes
FROM provenance_records
ORDER BY recorded_at DESC;
