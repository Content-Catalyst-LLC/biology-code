# Reproducibility Notes

## Data

All example datasets in `data/` are synthetic and small. They demonstrate structure rather than represent real plant physiological, ecosystem, or remote-sensing measurements.

## Provenance

The SQL schema includes fields for:

- productivity sites
- light-response scenarios
- biomass recovery scenarios
- plant condition sites
- model outputs
- data source
- analytical method
- license
- uncertainty notes

This supports transparent plant-biology workflows where results can be traced back to data sources and modeling assumptions.

## Randomness

The included examples are deterministic. Future stochastic extensions should set random seeds and record parameter assumptions.

## Limitations

The examples do not include:

- flux-tower calibration
- remote-sensing raster processing
- spectral vegetation indices
- species-specific photosynthesis parameters
- stomatal conductance models
- crop growth models
- hydrologic coupling
- Bayesian parameter estimation
- spatial ecological models
- plant disease transmission models

Those extensions can be added as the repository grows.
