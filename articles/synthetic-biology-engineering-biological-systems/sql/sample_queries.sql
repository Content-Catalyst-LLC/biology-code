.mode column
.headers on

SELECT
    design_id,
    construct_type,
    chassis,
    ROUND(
        output_signal * 0.40
        + genetic_stability * 0.30
        - host_burden * 0.20
        - measurement_uncertainty * 0.10,
        4
    ) AS engineering_score
FROM designs
ORDER BY engineering_score DESC;

SELECT
    design_id,
    ROUND((mean_signal - mean_background) / background_sd, 4) AS signal_to_noise,
    measurement_unit
FROM biosensor_measurements
ORDER BY signal_to_noise DESC;

SELECT
    design_id,
    chassis,
    ROUND(
        CASE
            WHEN growth_rate_control = 0 THEN 0
            ELSE 1 - growth_rate_engineered / growth_rate_control
        END,
        4
    ) AS burden_score
FROM host_burden
ORDER BY burden_score ASC;

SELECT
    run_id,
    design_id,
    ROUND(product_formed_g_l / substrate_consumed_g_l, 4) AS product_yield,
    product_name
FROM metabolic_runs
ORDER BY product_yield DESC;

SELECT
    part_type,
    COUNT(*) AS n_parts
FROM construct_parts
GROUP BY part_type
ORDER BY part_type;
