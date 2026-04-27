# Methodology Notes

## Purpose

This repository demonstrates reproducible computational scaffolding for making ethical assumptions visible in biological research.

## Ethical Review Score

The synthetic ethical-review score is calculated as:

ethical_review_score =
  expected_benefit * 0.25
  - expected_harm * 0.20
  - uncertainty * 0.15
  + consent_quality * 0.15
  + justice_score * 0.15
  + reversibility * 0.10

This score is a transparency tool, not a moral decision rule.

## Consent Completeness

consent_completeness =
  elements_understood / elements_required

## Justice-Adjusted Benefit

justice_adjusted_benefit =
  expected_benefit * (1 - inequality_penalty)

## Ecological Risk

ecological_risk =
  exposure_probability * harm_magnitude * uncertainty

## Reversibility-Adjusted Risk

reversibility_adjusted_risk =
  ecological_risk * (1 - reversibility)

## Scientific and Ethical Caution

These workflows do not decide whether research is ethical. They organize assumptions for accountable human review.
