# Methodology Notes

## Purpose

This repository demonstrates reproducible machine-learning scaffolding for life-science research.

## Biological Unit of Analysis

The synthetic dataset uses sample_id as the unit of analysis. In real studies, the correct unit might be patient, organism, tissue section, field site, sequencing run, image slide, species, ecosystem plot, or time window.

## Leakage Awareness

Machine-learning validation must prevent biological information from leaking between training and validation data. Examples include duplicated samples, repeated measures, image tiles from the same slide, related organisms, time-series leakage, batch effects, or preprocessing before data splitting.

## Model Type

The Python workflow uses a random forest classifier for demonstration. The R workflow uses logistic regression for interpretability. Neither model should be interpreted as biologically validated.

## Evaluation

The workflows calculate:

- accuracy
- sensitivity
- specificity
- precision
- F1 score
- ROC AUC where supported
- Brier score for probabilistic calibration
- confusion matrix counts

## Feature Importance

Feature importance is useful for model inspection, not proof of mechanism. In biological research, feature importance should be followed by external validation, sensitivity analysis, and experimental or mechanistic review.

## External Validation

The external validation example uses a separate synthetic dataset. Real external validation should involve independent data from a different cohort, site, laboratory, field campaign, instrument, time period, or biological population depending on intended use.
