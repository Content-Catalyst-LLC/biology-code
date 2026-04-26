# Reproducibility Notes

## Data

All example datasets in `data/` are synthetic and small. They demonstrate structure rather than represent real ecological, genomic, conservation, disease, or fitness measurements.

## Provenance

The SQL schema includes fields for:

- genotype selection scenarios
- quantitative trait observations
- variable environment scenarios
- allele-frequency time series
- selection condition sites
- model outputs
- data source
- analytical method
- license
- uncertainty notes

This supports transparent selection workflows where results can be traced back to data sources and modeling assumptions.

## Randomness

The Python stochastic examples set random seeds. Future stochastic extensions should record seeds, parameter distributions, and assumptions.

## Limitations

The examples do not include:

- empirical field fitness data
- capture-mark-recapture survival models
- genomic selection scans
- linkage disequilibrium
- polygenic architecture
- Bayesian fitness inference
- explicit ecological interaction models
- experimental evolution plate data
- treatment-resistance monitoring pipelines
- formal conservation genetic risk assessment

Those extensions can be added as the repository grows.
