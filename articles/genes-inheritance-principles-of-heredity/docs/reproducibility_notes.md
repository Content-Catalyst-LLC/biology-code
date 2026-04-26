# Reproducibility Notes

## Data

All example datasets in `data/` are synthetic and small. They demonstrate structure rather than represent real family, breeding, clinical, ecological, conservation, or population-genomic measurements.

## Provenance

The SQL schema includes fields for:

- cross observations
- genotype counts
- allele frequency examples
- recombination observations
- quantitative trait records
- heredity condition sites
- model outputs
- data source
- analytical method
- license
- uncertainty notes

This supports transparent heredity workflows where results can be traced back to data sources and modeling assumptions.

## Randomness

Python and R stochastic examples set random seeds. Future stochastic extensions should record seeds, sample sizes, parameter distributions, and assumptions.

## Limitations

The examples do not include:

- real pedigree data
- clinical variant interpretation
- linkage mapping
- QTL mapping
- association studies
- genome-wide association scans
- phasing
- Bayesian inheritance inference
- population stratification correction
- conservation management thresholds

Those extensions can be added as the repository grows.
