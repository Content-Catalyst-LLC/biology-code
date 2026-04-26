# Reproducibility Notes

## Data

All example datasets in `data/` are synthetic and small. They demonstrate structure rather than represent real population-genetic, sequence, fossil, or phylogenetic measurements.

## Provenance

The SQL schema includes fields for:

- divergence scenarios
- aligned sequence examples
- birth-death scenarios
- speciation diagnostic sites
- model outputs
- data source
- analytical method
- license
- uncertainty notes

This supports transparent speciation workflows where results can be traced back to data sources and modeling assumptions.

## Randomness

The Python and R stochastic examples set random seeds. Future stochastic extensions should record seeds, parameter distributions, and assumptions.

## Limitations

The examples do not include:

- real genomic alignments
- explicit species-tree inference
- coalescent inference
- Bayesian phylogenetics
- reticulate-network inference
- horizontal gene transfer detection
- incomplete-lineage-sorting model fitting
- fossil calibration
- divergence-time estimation
- formal species delimitation

Those extensions can be added as the repository grows.
