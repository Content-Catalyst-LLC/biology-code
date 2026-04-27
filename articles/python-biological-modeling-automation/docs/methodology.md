# Methodology Notes

## Purpose

This repository demonstrates a reproducible Python-first workflow for biological modeling and automation.

## Logistic Growth

dN/dt = rN(1 - N/K)

where:

- N is population size
- r is intrinsic growth rate
- K is carrying capacity

The basic simulation uses Euler approximation:

N_next = N + dt * rN(1 - N/K)

## Two-Compartment Model

dA/dt = -k_ab A + k_ba B - k_clear A

dB/dt = k_ab A - k_ba B

where:

- A and B are biological compartments
- k_ab is the transfer rate from A to B
- k_ba is the transfer rate from B to A
- k_clear is clearance from compartment A

## Parameter Sweep

Each scenario is a row in the parameter table. Automation runs the same model across all scenarios and records outputs.

## Sensitivity Scaffold

Sensitivity is estimated by comparing final output changes across scenario values.

## Automation

The workflow includes:

- input validation
- simulation execution
- scenario comparison
- provenance manifest
- report generation
- SQL schema
- cross-language checks

These examples are educational scaffolds and should be adapted with domain-specific validation for real research.
