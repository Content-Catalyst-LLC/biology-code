# Reproducibility Notes

## Data

All example datasets in `data/` are synthetic and small. They demonstrate structure rather than represent real fungal ecological measurements.

## Provenance

The SQL schema includes fields for:

- fungal guilds
- decomposition site scenarios
- fungal condition indicators
- recovery scenarios
- network edges
- model outputs
- data source
- analytical method
- license
- uncertainty notes

This supports transparent fungal-biology workflows where results can be traced back to data sources and modeling assumptions.

## Randomness

The Python stochastic decomposition example sets a random seed for reproducibility. Future stochastic extensions should record seeds and parameter settings.

## Limitations

The examples do not include:

- field-calibrated decomposition constants
- microbial community sequencing pipelines
- fungal functional guild assignment from sequence data
- enzyme kinetics
- isotope tracing
- metagenomics or metatranscriptomics
- spatially explicit hyphal growth
- agent-based fungal competition
- Bayesian parameter estimation
- clinical fungal diagnostics

Those extensions can be added as the repository grows.
