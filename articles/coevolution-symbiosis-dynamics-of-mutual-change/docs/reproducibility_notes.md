# Reproducibility Notes

## Data

All example datasets in `data/` are synthetic and small. They demonstrate structure rather than represent real host-symbiont, disease, pollination, or phylogenetic measurements.

## Provenance

The SQL schema includes fields for:

- interaction scenarios
- benefit-cost parameters
- reciprocal frequency scenarios
- host-pathogen dynamics
- network edges
- model outputs
- data source
- analytical method
- license
- uncertainty notes

This supports transparent coevolution workflows where results can be traced back to data sources and modeling assumptions.

## Randomness

The included examples are deterministic. Future stochastic extensions should set random seeds and record parameter assumptions.

## Limitations

The examples do not include:

- empirical host-symbiont genotype data
- phylogenetic comparative analysis
- cophylogenetic reconciliation
- genomic scans for selection
- pathogen transmission modeling
- spatial geographic mosaic modeling
- Bayesian evolutionary inference
- empirical pollination-network fitting
- microbiome sequence analysis

Those extensions can be added as the repository grows.
