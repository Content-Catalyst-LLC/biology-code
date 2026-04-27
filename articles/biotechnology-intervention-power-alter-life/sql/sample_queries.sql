.mode column
.headers on

SELECT
    intervention,
    domain,
    scale,
    ROUND(
        expected_benefit * 0.30
        + access_equity * 0.20
        + reversibility * 0.20
        + governance_readiness * 0.15
        - expected_harm * 0.10
        - uncertainty * 0.05,
        4
    ) AS responsibility_score
FROM biotechnology_interventions
ORDER BY responsibility_score DESC;

SELECT
    category,
    COUNT(*) AS n_layers,
    ROUND(AVG(failure_probability), 4) AS mean_failure_probability
FROM containment_layers
GROUP BY category
ORDER BY category;

SELECT
    scenario,
    ROUND(exposure * magnitude * uncertainty, 4) AS risk_score,
    ROUND(monitoring_capacity * reversibility, 4) AS governance_buffer
FROM ecological_release_scenarios
ORDER BY risk_score DESC;

SELECT
    intervention,
    ROUND(nominal_availability * (1 - inequality_penalty), 4) AS equity_adjusted_access,
    implementation_infrastructure
FROM access_equity
ORDER BY equity_adjusted_access DESC;
