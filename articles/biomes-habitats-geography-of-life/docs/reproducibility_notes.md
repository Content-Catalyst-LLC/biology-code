# Reproducibility Notes

## Data

All example datasets in `data/` are synthetic and small. They demonstrate structure rather than represent real-world assessments.

## Provenance

The SQL schema includes fields for:

- biome classification
- habitat classification
- occurrence record
- predictor source
- scenario definition
- observation method
- license
- processing step
- uncertainty notes

This supports transparent biogeography workflows where results can be traced back to data sources and modeling assumptions.

## Randomness

Simulation scripts set random seeds where practical. Results should be reproducible under similar language versions and package versions.

## Limitations

The examples do not include:

- real GIS rasters
- spatial autocorrelation correction
- sampling-bias correction
- MaxEnt or Bayesian SDMs
- environmental niche modeling ensembles
- remote-sensing classification pipelines
- marine bathymetric grids
- eDNA pipelines
- spatially explicit dispersal models

Those extensions can be added as the repository grows.
