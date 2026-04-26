# Validation Notes

The repository includes simple validation checks appropriate for an educational scientific-computing scaffold.

## Input Validation

- Time values must be non-negative.
- Correction rates must be non-negative.
- Growth abundances must be positive for log-linear fitting.
- Carrying capacity must exceed initial abundance in logistic examples.
- Network weights must be non-negative.
- Condition-score variables are expected to be scaled between 0 and 1.

## Numerical Checks

- Homeostatic simulations report final deviation from setpoint.
- Recovery indices are calculated relative to initial perturbation magnitude.
- Growth fitting is performed in log space.
- Logistic growth remains bounded by carrying capacity.
- Network summaries report degree and weighted degree.
- Scoring functions validate unit-interval input fields.

## Reproducibility Checks

- Synthetic datasets are small and versioned.
- Model assumptions are documented in `docs/methodology.md`.
- SQL provenance records describe source, method, license, and uncertainty.
- Notebook scaffolds reproduce the main table calculations.

## Limitations

The validation checks are not substitutes for empirical quality control. Research, clinical, ecological, environmental, industrial, or regulatory use would require stronger validation, calibration, sensitivity analysis, uncertainty propagation, domain review, and audit trails.
