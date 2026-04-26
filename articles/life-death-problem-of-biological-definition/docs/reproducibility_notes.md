# Reproducibility Notes

## Data

All example datasets in `data/` are synthetic and small. They demonstrate computational structure rather than represent real clinical, ecological, astrobiology, virology, toxicology, or biosafety measurements.

## Provenance

The SQL schema includes fields for:

- viability observations
- dormancy scenarios
- host-virus scenarios
- life-criteria weights
- borderline-case criteria
- model outputs
- data source
- analytical method
- license
- uncertainty notes

## Randomness

The core examples are deterministic. Future stochastic extensions should record seeds, parameter distributions, sample sizes, assay metadata, instrument metadata, and model versions.

## Limitations

The examples do not include:

- clinical death determination
- diagnostic viability testing
- validated viral kinetics
- immune-system modeling
- astrobiology biosignature inference
- regulatory biosafety workflows
- Bayesian calibration
- uncertainty propagation

Those extensions can be added as the repository grows.
