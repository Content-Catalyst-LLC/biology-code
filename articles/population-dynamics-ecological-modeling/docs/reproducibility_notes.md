# Reproducibility Notes

## Data

All example datasets in `data/` are synthetic and small. They demonstrate structure rather than represent real population assessments.

## Provenance

The SQL schema includes fields for:

- population records
- vital rates
- stage matrices
- scenario definitions
- simulation outputs
- model assumptions
- data source
- analytical method
- license
- uncertainty notes

This supports transparent population ecology workflows where results can be traced back to data sources and modeling assumptions.

## Randomness

Simulation scripts set random seeds where practical. Results should be reproducible under similar language versions and package versions.

## Limitations

The examples do not include:

- formal Bayesian inference
- state-space estimation
- integrated population models
- observation error
- detection probability
- spatially explicit dispersal
- genetic stochasticity
- full fisheries stock assessment
- management strategy evaluation
- climate-driver ensembles

Those extensions can be added as the repository grows.
