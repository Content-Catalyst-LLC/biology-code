# Methodology Notes

## Purpose

This repository demonstrates a reproducible computational ecology workflow using synthetic data.

## Habitat Suitability

A logistic transformation converts environmental covariates into a bounded suitability score.

Inputs include:

- temperature
- precipitation
- habitat quality
- disturbance

## Patch Occupancy

Patch occupancy follows:

p_next = p * (1 - extinction) + (1 - p) * colonization

This simple scaffold can be extended with habitat quality, connectivity, stochasticity, and detection probability.

## Environmental Stress

A stress index combines temperature anomaly, water deficit, disturbance, and restoration gain.

## Runoff Scaffold

A simple runoff scaffold calculates:

runoff = precipitation * (1 - infiltration_fraction) * runoff_coefficient

This is not a production hydrological model.

## Validation Metrics

Validation metrics include:

- RMSE
- MAE
- Bias

## Reproducibility

The repository records:

- input data files
- scripts
- output artifacts
- checksums
- workflow steps
- SQL provenance
- validation reports
