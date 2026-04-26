# Reproducibility Notes

## Data

All example datasets in `data/` are synthetic and small. They demonstrate structure rather than represent real immunological measurements.

## Provenance

The SQL schema includes fields for:

- immune compartments
- model parameters
- immune scenarios
- threshold definitions
- model outputs
- data source
- analytical method
- license
- uncertainty notes

This supports transparent immunology workflows where results can be traced back to data sources and modeling assumptions.

## Randomness

The included examples are deterministic. Future stochastic extensions should set random seeds and record parameter settings.

## Limitations

The examples do not include:

- calibrated within-host infection models
- stochastic immune-cell dynamics
- immune repertoire modeling
- antibody affinity maturation
- antigen presentation details
- cytokine network calibration
- spatial tissue simulation
- single-cell RNA-seq pipelines
- agent-based immune simulation
- clinical inference

Those extensions can be added as the repository grows.
