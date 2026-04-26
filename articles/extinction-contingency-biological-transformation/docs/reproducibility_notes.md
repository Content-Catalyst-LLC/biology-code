# Reproducibility Notes

## Data

All example datasets in `data/` are synthetic and small. They demonstrate structure rather than represent real fossil, conservation, phylogenetic, or biodiversity measurements.

## Provenance

The SQL schema includes fields for:

- clade survivorship data
- hazard scenarios
- recovery scenarios
- trait-risk data
- phylogenetic-loss data
- extinction condition sites
- model outputs
- data source
- analytical method
- license
- uncertainty notes

This supports transparent extinction workflows where results can be traced back to data sources and modeling assumptions.

## Randomness

The Python stochastic survivorship example sets a random seed for reproducibility. Future stochastic extensions should record seeds, parameter distributions, and assumptions.

## Limitations

The examples do not include:

- fossil occurrence databases
- sampling-standardization methods
- preservation-bias models
- birth-death diversification models
- phylogenetic comparative inference
- formal IUCN assessment criteria
- spatial extinction-risk modeling
- Bayesian survival models
- paleoclimate covariates
- real species or clade data

Those extensions can be added as the repository grows.
