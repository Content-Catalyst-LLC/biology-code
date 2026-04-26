# Reproducibility Notes

## Data

All example datasets in `data/` are synthetic and small. They demonstrate structure rather than represent real physiological measurements.

## Provenance

The SQL schema includes fields for:

- physiological variables
- feedback scenarios
- regulatory condition scenarios
- threshold definitions
- model outputs
- data source
- analytical method
- license
- uncertainty notes

This supports transparent physiology workflows where results can be traced back to data sources and modeling assumptions.

## Randomness

The included examples are deterministic. Future stochastic extensions should set random seeds and record parameter settings.

## Limitations

The examples do not include:

- calibrated clinical physiology models
- pharmacokinetics or pharmacodynamics
- detailed endocrine pathway models
- kidney, cardiovascular, respiratory, or plant hydraulic submodels
- spatial tissue simulation
- agent-based physiology
- experimental parameter estimation
- Bayesian uncertainty models
- real sensor data streams
- clinical inference

Those extensions can be added as the repository grows.
