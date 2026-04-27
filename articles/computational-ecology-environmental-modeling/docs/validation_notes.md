# Validation Notes

## Ecological Modeling

- Habitat suitability should not be interpreted as confirmed presence.
- Occurrence and abundance observations may reflect sampling effort.
- Detection probability is not modeled in these simplified examples.
- Spatial autocorrelation is not addressed in the core scaffold.
- Models should be validated against independent observations.

## Environmental Modeling

- Remote-sensing and gridded environmental data require scale and uncertainty review.
- Runoff scaffolds are simplified and should not be used for engineering design.
- Climate-stress scenarios are conditional, not predictions.
- Units must be explicit.
- Coordinate systems and spatial resolution should be documented in real workflows.

## Reproducibility

- Required input files should exist before execution.
- Scenario identifiers should be unique.
- Scripts should fail clearly when inputs are invalid.
- Provenance should record inputs, outputs, scripts, and checksums.
- Reports should include assumptions and limitations.

## Limitations

The examples do not implement occupancy-detection models, species distribution modeling with bias correction, hydrological routing, mechanistic carbon-cycle modeling, remote-sensing preprocessing, spatial autocorrelation, Bayesian forecasting, or operational ecological forecasting.
