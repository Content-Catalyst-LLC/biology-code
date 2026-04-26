# Reproducibility Notes

## Data

All example datasets in `data/` are synthetic and small. They are designed to demonstrate structure, not to represent a real conservation assessment.

## Provenance

The SQL schema includes fields for:

- source name
- collection method
- observer
- date recorded
- uncertainty notes
- license
- processing step

This supports transparent conservation workflows where results can be traced back to data sources and assumptions.

## Randomness

Simulation scripts set random seeds where practical. Results should be reproducible under similar language versions and package versions.

## Limitations

The examples do not include:

- age-structured demography
- spatially explicit GIS layers
- Bayesian posterior uncertainty
- full metapopulation parameter estimation
- genomic data
- remote sensing pipelines
- species distribution modeling

Those extensions can be added as the repository grows.
