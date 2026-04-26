# Reproducibility Notes

## Data

All example datasets in `data/` are synthetic and small. They demonstrate structure rather than represent real behavioral datasets.

## Provenance

The SQL schema includes fields for:

- behavioral options
- signaling strategies
- environmental scenarios
- conflict parameters
- model outputs
- data source
- analytical method
- license
- uncertainty notes

This supports transparent behavioral workflows where results can be traced back to data sources and modeling assumptions.

## Randomness

The C++ Hawk-Dove example is deterministic by default. Future stochastic extensions should set random seeds and record parameter settings.

## Limitations

The examples do not include:

- empirical behavioral annotation
- acoustic or video feature extraction
- machine-learning behavior classification
- movement ecology trajectories
- state-space behavioral models
- social network inference
- sensory detection calibration
- field validation
- Bayesian uncertainty models

Those extensions can be added as the repository grows.
