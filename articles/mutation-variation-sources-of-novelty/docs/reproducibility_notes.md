# Reproducibility Notes

## Data

All example datasets in `data/` are synthetic and small. They demonstrate structure rather than represent real sequence, genotype, structural-variant, clinical, conservation, or population-genomic measurements.

## Provenance

The SQL schema includes fields for:

- mutation spectra
- aligned sequences
- genotype site summaries
- structural variants
- novelty condition sites
- model outputs
- data source
- analytical method
- license
- uncertainty notes

This supports transparent variation workflows where results can be traced back to data sources and modeling assumptions.

## Randomness

Python and R stochastic examples set random seeds. Future stochastic extensions should record seeds, parameter distributions, sample sizes, and assumptions.

## Limitations

The examples do not include:

- raw sequencing reads
- quality control
- read alignment
- variant calling
- phasing
- linkage disequilibrium
- ancestry modeling
- structural variant breakpoint validation
- clinical pathogenicity classification
- conservation-genomic decision thresholds
- formal Bayesian inference

Those extensions can be added as the repository grows.
