# Reproducibility Notes

## Data

All example datasets in `data/` are synthetic and small. They demonstrate structure rather than represent real genomic, conservation, disease, or population measurements.

## Provenance

The SQL schema includes fields for:

- single-locus evolutionary scenarios
- genotype observations
- multi-population allele frequencies
- migration-selection scenarios
- population condition sites
- model outputs
- data source
- analytical method
- license
- uncertainty notes

This supports transparent population-genetic workflows where results can be traced back to data sources and modeling assumptions.

## Randomness

The Python and R stochastic examples set random seeds. Future stochastic extensions should record seeds, parameter distributions, and assumptions.

## Limitations

The examples do not include:

- empirical variant-call files
- missing-data modeling
- linkage disequilibrium
- recombination maps
- polygenic selection
- coalescent inference
- demographic history fitting
- genome-wide association analysis
- ancestry deconvolution
- formal conservation genetic risk assessment

Those extensions can be added as the repository grows.
