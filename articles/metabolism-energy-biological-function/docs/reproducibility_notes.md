# Reproducibility Notes

## Data

All example datasets in `data/` are synthetic and small. They demonstrate computational structure rather than represent real clinical, ecological, fermentation, genomic, environmental, or metabolic measurements.

## Provenance

The SQL schema includes fields for:

- growth observations
- substrate observations
- oxygen-consumption observations
- energy-budget scenarios
- flux reaction definitions
- metabolic condition sites
- model outputs
- data source
- analytical method
- license
- uncertainty notes

## Randomness

The core examples are deterministic. Future stochastic extensions should record seeds, parameter distributions, sample sizes, uncertainty assumptions, and model versions.

## Limitations

The examples do not include:

- isotope tracing
- metabolomics normalization
- genome-scale reconstructions
- kinetic parameter uncertainty
- dynamic flux-balance analysis
- full thermodynamic constraints
- Bayesian calibration
- environmental sensor QA/QC
- clinical interpretation
- regulatory reporting

Those extensions can be added as the repository grows.
