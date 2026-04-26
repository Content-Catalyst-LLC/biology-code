# Reproducibility Notes

## Data

All example datasets in `data/` are synthetic and small. They demonstrate structure rather than represent real genomic, fossil, phylogenetic, ecological, or paleobiological measurements.

## Provenance

The SQL schema includes fields for:

- evolutionary scenarios
- aligned sequence examples
- birth-death scenarios
- major transition records
- evolutionary condition sites
- model outputs
- data source
- analytical method
- license
- uncertainty notes

This supports transparent evolutionary workflows where results can be traced back to data sources and modeling assumptions.

## Randomness

The Python and R stochastic examples set random seeds. Future stochastic extensions should record seeds, parameter distributions, and assumptions.

## Limitations

The examples do not include:

- real genomic alignments
- formal phylogenetic inference
- fossil occurrence databases
- stratigraphic range estimation
- sampling-standardization methods
- Bayesian birth-death inference
- coalescent inference
- demographic history fitting
- comparative methods
- formal conservation prioritization

Those extensions can be added as the repository grows.
