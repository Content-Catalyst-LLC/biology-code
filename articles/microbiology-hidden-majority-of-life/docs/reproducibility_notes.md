# Reproducibility Notes

## Data

All example datasets in `data/` are synthetic and small. They demonstrate structure rather than represent real microbial ecological or clinical measurements.

## Provenance

The SQL schema includes fields for:

- microbial growth environments
- Monod growth scenarios
- intervention scenarios
- community condition sites
- model outputs
- data source
- analytical method
- license
- uncertainty notes

This supports transparent microbiology workflows where results can be traced back to data sources and modeling assumptions.

## Randomness

The Python Monte Carlo example sets a random seed for reproducibility. Future stochastic extensions should record seeds, parameter distributions, and sampling assumptions.

## Limitations

The examples do not include:

- empirical microbial abundance data
- amplicon or metagenomic pipelines
- absolute abundance correction
- microbial process-rate calibration
- genome-resolved metabolic reconstruction
- strain-level pathogen modeling
- antimicrobial resistance mechanism modeling
- wastewater reactor calibration
- Bayesian parameter estimation
- clinical inference

Those extensions can be added as the repository grows.
