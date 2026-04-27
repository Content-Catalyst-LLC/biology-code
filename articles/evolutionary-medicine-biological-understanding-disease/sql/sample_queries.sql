.mode column
.headers on

SELECT
    trait_system,
    biological_domain,
    ROUND(ABS(current_exposure - adapted_exposure_reference), 4) AS mismatch_distance,
    ROUND(ABS(current_exposure - adapted_exposure_reference) * evidence_confidence, 4) AS weighted_mismatch_score
FROM mismatch_exposures
ORDER BY weighted_mismatch_score DESC;

SELECT
    scenario,
    ROUND(growth + reproduction + maintenance + immune_defense, 4) AS total_allocation,
    ROUND(1 - maintenance, 4) AS maintenance_risk_index,
    ROUND(immune_defense * (1 - maintenance), 4) AS inflammation_pressure_index
FROM life_history_allocation
ORDER BY maintenance_risk_index DESC;

SELECT
    clone_id,
    ROUND(initial_clone_size * EXP(growth_rate * time_steps), 2) AS final_clone_size,
    selection_context
FROM somatic_evolution_scenarios
ORDER BY final_clone_size DESC;

SELECT
    defense_system,
    CASE
        WHEN threat_level >= activation_threshold THEN 'activated'
        ELSE 'not_activated'
    END AS defense_status,
    ROUND(threat_level - activation_threshold, 4) AS threshold_margin
FROM defense_thresholds
ORDER BY threshold_margin DESC;

SELECT
    disease_area,
    evolutionary_mechanism,
    COUNT(*) AS n_scenarios
FROM disease_scenarios
GROUP BY disease_area, evolutionary_mechanism
ORDER BY disease_area;
