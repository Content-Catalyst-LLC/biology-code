# Reproducibility Notes

## Data

All example datasets in `data/` are synthetic and small. They demonstrate computational structure rather than represent real clinical, ecological, marine, physiological, or biotechnology measurements.

## Provenance

The SQL schema includes fields for:

- homeostasis scenarios
- growth observations
- feedback scenarios
- biological network edges
- living-order condition sites
- model outputs
- data source
- analytical method
- license
- uncertainty notes

## Randomness

The core examples are deterministic. Future stochastic extensions should record seeds, parameter distributions, sample sizes, sensor metadata, calibration assumptions, and model versions.

## Limitations

The examples do not include:

- clinical interpretation
- ecological forecasting
- multi-species dynamic simulation
- Bayesian calibration
- uncertainty propagation
- differential-equation solvers beyond simple examples
- validated disease models
- regulatory reporting

Those extensions can be added as the repository grows.
