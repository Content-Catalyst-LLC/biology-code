# Reproducibility Notes

## Data

All example datasets in `data/` are synthetic and small. They demonstrate structure rather than represent real wildlife, laboratory, or conservation measurements.

## Provenance

The SQL schema includes fields for:

- species traits
- allometry parameters
- recovery scenarios
- survival scenarios
- stage matrices
- condition screening
- model outputs
- data source
- analytical method
- license
- uncertainty notes

This supports transparent animal-biology workflows where results can be traced back to data sources and modeling assumptions.

## Randomness

The included examples are deterministic. Future stochastic extensions should set random seeds and record parameter assumptions.

## Limitations

The examples do not include:

- species-specific demographic calibration
- movement tracking or telemetry workflows
- spatial habitat models
- age-specific survival estimation
- Bayesian state-space models
- disease transmission models
- biomechanical locomotion models
- physiological thermal-performance curves
- genomic pipelines
- clinical inference

Those extensions can be added as the repository grows.
