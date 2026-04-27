.mode column
.headers on

SELECT
    project,
    domain,
    ROUND(
        expected_benefit * 0.25
        - expected_harm * 0.20
        - uncertainty * 0.15
        + consent_quality * 0.15
        + justice_score * 0.15
        + reversibility * 0.10,
        4
    ) AS ethical_review_score
FROM biology_ethics_projects
ORDER BY ethical_review_score DESC;

SELECT
    study,
    participant_group,
    ROUND(CAST(elements_understood AS REAL) / elements_required, 4) AS consent_completeness,
    CASE
        WHEN CAST(elements_understood AS REAL) / elements_required < 0.75 THEN 'review'
        ELSE 'adequate_for_scaffold'
    END AS consent_flag
FROM consent_records
ORDER BY consent_completeness ASC;

SELECT
    intervention,
    ROUND(expected_benefit * (1 - inequality_penalty), 4) AS justice_adjusted_benefit,
    primary_beneficiary,
    access_constraint
FROM justice_benefit
ORDER BY justice_adjusted_benefit DESC;

SELECT
    project,
    ROUND(exposure_probability * harm_magnitude * uncertainty, 4) AS ecological_risk,
    ROUND(exposure_probability * harm_magnitude * uncertainty * (1 - reversibility), 4) AS reversibility_adjusted_risk
FROM ecological_risk
ORDER BY reversibility_adjusted_risk DESC;

SELECT
    project,
    requires_irb + requires_animal_review + requires_biosafety_review + requires_community_consultation + requires_data_governance + requires_ecological_assessment AS n_governance_requirements
FROM governance_requirements
ORDER BY n_governance_requirements DESC;
