# Reproducibility Notes

## Data

All example datasets in `data/` are synthetic and small. They demonstrate structure rather than represent real-world assessments.

## Provenance

The SQL schema includes fields for:

- reservoir name
- flux name
- indicator value
- scenario
- observation method
- analytical method
- license
- processing step
- uncertainty notes

This supports transparent biogeochemical workflows where results can be traced back to data sources and modeling assumptions.

## Randomness

Simulation scripts set random seeds where practical. Results should be reproducible under similar language versions and package versions.

## Limitations

The examples do not include:

- full Earth-system model coupling
- watershed hydrology
- marine carbonate chemistry solvers
- microbial pathway parameter estimation
- Bayesian posterior uncertainty
- isotope models
- spatially explicit raster data
- data assimilation
- reaction-transport modeling

Those extensions can be added as the repository grows.
