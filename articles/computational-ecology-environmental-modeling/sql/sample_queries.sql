.headers on
.mode column

SELECT
    site_id,
    temperature_c,
    precipitation_mm,
    habitat_quality,
    disturbance,
    observed_presence,
    observed_abundance
FROM sites
ORDER BY site_id;

SELECT
    scenario,
    temperature_anomaly,
    water_deficit,
    disturbance,
    habitat_gain,
    colonization,
    extinction
FROM scenarios
ORDER BY scenario;

SELECT
    cell_id,
    land_cover,
    precipitation_mm,
    infiltration_fraction,
    runoff_coefficient,
    ROUND(precipitation_mm * (1 - infiltration_fraction) * runoff_coefficient, 5) AS runoff_mm
FROM environmental_grid
ORDER BY cell_id;

SELECT
    AVG(observed_abundance - predicted_abundance) AS bias,
    AVG(ABS(observed_abundance - predicted_abundance)) AS mean_absolute_error
FROM validation_observations;

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
