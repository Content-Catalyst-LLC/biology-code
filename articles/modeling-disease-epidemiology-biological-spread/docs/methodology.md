# Methodology Notes

## Purpose

This repository demonstrates a reproducible educational workflow for disease modeling, epidemiology, and biological spread.

## SIR Model

The SIR model tracks:

- susceptible
- infected
- recovered or removed

Core dynamics:

dS/dt = -beta * S * I / N
dI/dt = beta * S * I / N - gamma * I
dR/dt = gamma * I

## SEIR Model

The SEIR model adds an exposed compartment:

dE/dt = beta * S * I / N - sigma * E
dI/dt = sigma * E - gamma * I

## Rt Proxy

The Rt proxy script uses short-window case growth as a teaching scaffold. It is not a validated Rt estimator.

## Branching Process

The branching-process example simulates generational spread with stochastic secondary cases. It is a methodological scaffold.

## Reporting Delay

The reporting-delay scaffold divides reported cases by an estimated completeness fraction. This illustrates nowcasting logic but is not a production nowcast.

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
