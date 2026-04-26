# Reproducibility Notes

## Data

All example datasets in `data/` are synthetic and small. They demonstrate computational structure rather than represent real clinical, ecological, marine, hydrological, bioreactor, or environmental measurements.

## Provenance

The SQL schema includes fields for:

- solute conditions
- water-potential scenarios
- homeostasis scenarios
- growth observations
- oxygen scenarios
- energy budgets
- material-condition sites
- model outputs
- data source
- analytical method
- license
- uncertainty notes

## Randomness

The core examples are deterministic. Future stochastic extensions should record seeds, parameter distributions, sample sizes, sensor metadata, calibration assumptions, and model versions.

## Limitations

The examples do not include:

- real physiological measurements
- full electrolyte models
- coupled fluid dynamics
- hydrological routing
- carbonate chemistry
- clinical interpretation
- regulatory environmental reporting
- bioreactor control loops
- Bayesian calibration
- uncertainty propagation

Those extensions can be added as the repository grows.
