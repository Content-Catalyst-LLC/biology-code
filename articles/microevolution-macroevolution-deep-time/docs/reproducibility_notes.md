# Reproducibility Notes

## Data

All example datasets in `data/` are synthetic and small. They demonstrate structure rather than represent real population-genetic, sequence, fossil, or phylogenetic measurements.

## Provenance

The SQL schema includes fields for:

- population scenarios
- aligned sequence examples
- clade turnover data
- birth-death scenarios
- model outputs
- data source
- analytical method
- license
- uncertainty notes

This supports transparent evolutionary-scale workflows where results can be traced back to data sources and modeling assumptions.

## Randomness

The Python and R stochastic examples set random seeds. Future stochastic extensions should record seeds, parameter distributions, and assumptions.

## Limitations

The examples do not include:

- real genomic alignments
- phylogenetic reconstruction algorithms
- fossil occurrence databases
- sampling-standardization methods
- Bayesian birth-death inference
- structured coalescent models
- demographic history inference
- selection scans
- comparative-methods pipelines
- formal conservation prioritization

Those extensions can be added as the repository grows.
