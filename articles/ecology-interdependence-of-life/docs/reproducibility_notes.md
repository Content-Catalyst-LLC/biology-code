# Reproducibility Notes

## Data

All example datasets in `data/` are synthetic and small. They demonstrate structure rather than represent real ecological assessments.

## Provenance

The SQL schema includes fields for:

- site records
- species records
- abundance observations
- interaction records
- ecosystem indicators
- scenario definitions
- network metrics
- analytical method
- license
- uncertainty notes

This supports transparent ecology workflows where results can be traced back to data sources and modeling assumptions.

## Randomness

Simulation scripts set random seeds where practical. Results should be reproducible under similar language versions and package versions.

## Limitations

The examples do not include:

- spatially explicit dispersal
- formal food-web inference
- detection probability
- Bayesian uncertainty
- remote-sensing rasters
- eDNA processing
- hydrological coupling
- biogeochemical reaction models
- climate-driver ensembles
- management strategy evaluation

Those extensions can be added as the repository grows.
