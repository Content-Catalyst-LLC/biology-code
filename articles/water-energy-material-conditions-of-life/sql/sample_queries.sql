-- Example SQL queries for water-energy biology workflows.

.headers on
.mode column

SELECT
    scenario_id,
    van_t_hoff_factor,
    concentration_mol_L,
    temperature_K,
    van_t_hoff_factor * concentration_mol_L * 0.082057 * temperature_K AS osmotic_pressure_atm
FROM solute_conditions
ORDER BY osmotic_pressure_atm DESC;

SELECT
    scenario_id,
    solute_potential_MPa,
    pressure_potential_MPa,
    gravitational_potential_MPa,
    matric_potential_MPa,
    solute_potential_MPa + pressure_potential_MPa + gravitational_potential_MPa + matric_potential_MPa AS total_water_potential_MPa
FROM water_potential_scenarios
ORDER BY total_water_potential_MPa ASC;

SELECT
    scenario_id,
    initial_value,
    setpoint,
    correction_rate,
    CASE
        WHEN correction_rate > 0 THEN log(2.0) / correction_rate
        ELSE NULL
    END AS half_recovery_time
FROM homeostasis_scenarios
ORDER BY half_recovery_time ASC;

SELECT
    condition_name,
    COUNT(*) AS n_observations,
    MIN(time_h) AS first_time_h,
    MAX(time_h) AS last_time_h,
    MIN(abundance) AS min_abundance,
    MAX(abundance) AS max_abundance
FROM growth_observations
GROUP BY condition_name
ORDER BY condition_name;

SELECT
    scenario_id,
    oxygen_mg_L,
    half_saturation_mg_L,
    max_relative_energy_rate,
    max_relative_energy_rate * oxygen_mg_L / (half_saturation_mg_L + oxygen_mg_L) AS relative_energy_rate,
    1 - (max_relative_energy_rate * oxygen_mg_L / (half_saturation_mg_L + oxygen_mg_L)) AS oxygen_limitation
FROM oxygen_scenarios
ORDER BY oxygen_mg_L ASC;

SELECT
    scenario_id,
    energy_input,
    energy_growth / energy_input AS growth_fraction,
    energy_maintenance / energy_input AS maintenance_fraction,
    energy_repair / energy_input AS repair_fraction,
    energy_loss / energy_input AS loss_fraction,
    energy_input - energy_growth - energy_maintenance - energy_repair - energy_loss AS energy_balance_residual
FROM energy_budget_scenarios
ORDER BY scenario_id;

SELECT
    site_name,
    water_availability,
    osmotic_stability,
    energy_availability,
    oxygen_support,
    thermal_suitability,
    ph_stability,
    stress_penalty,
    0.17 * water_availability +
    0.15 * osmotic_stability +
    0.17 * energy_availability +
    0.14 * oxygen_support +
    0.13 * thermal_suitability +
    0.14 * ph_stability +
    0.10 * (1 - stress_penalty) AS material_condition_score
FROM material_condition_sites
ORDER BY material_condition_score DESC;

SELECT
    dataset_name,
    source_name,
    analytical_method,
    processing_step,
    uncertainty_notes
FROM provenance_records
ORDER BY recorded_at DESC;
