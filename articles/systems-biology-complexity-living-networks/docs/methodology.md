# Methodology Notes

## Purpose

This repository demonstrates a reproducible educational workflow for systems biology and living-network complexity.

## Network Summary

The workflow calculates node degree and basic network density from synthetic biological interactions.

## Signal Propagation

A directed weighted network propagates signal from an input node across downstream targets.

## Feedback Dynamics

A two-variable negative-feedback scaffold models dynamic regulation:

dx/dt = production_x / (1 + y^n) - degradation_x * x
dy/dt = production_y * x - degradation_y * y

## Pathway Activity

Pathway activity is calculated as the mean z-score across genes in a pathway gene set.

## Flux-Balance Scaffold

The flux scaffold calculates mass-balance residuals from a small stoichiometric table and a chosen flux vector. This illustrates constraint logic and is not a production FBA solver.

## Omics Integration

The integration workflow joins node metadata, network degree, pathway membership, expression state, and perturbation state.

## Validation

Validation metrics include:

- MAE
- RMSE
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
