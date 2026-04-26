# Reproducibility Notes

## Data

All example datasets in `data/` are synthetic and small. They demonstrate structure rather than represent real-world assessments.

## Provenance

The SQL schema includes fields for:

- source name
- observation method
- spatial unit
- indicator
- scenario
- uncertainty notes
- license
- processing step

This supports transparent biosphere workflows where results can be traced back to data sources and assumptions.

## Randomness

Simulation scripts set random seeds where practical. Results should be reproducible under similar language versions and package versions.

## Limitations

The examples do not include:

- full Earth-system model coupling
- remote-sensing raster workflows
- spatially explicit GIS layers
- Bayesian posterior uncertainty
- land-cover classification pipelines
- ocean biogeochemistry models
- data assimilation
- climate-model ensembles

Those extensions can be added as the repository grows.
