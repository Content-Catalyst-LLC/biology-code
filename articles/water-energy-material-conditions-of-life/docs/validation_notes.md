# Validation Notes

The repository includes simple validation checks appropriate for an educational scientific-computing scaffold.

## Input Validation

- Concentrations must be non-negative.
- Temperature in Kelvin must be positive.
- van 't Hoff factors must be positive.
- Correction rates must be non-negative.
- Growth abundances must be positive for log-linear fitting.
- Energy-budget components must not exceed input without being flagged.
- Condition-score variables are expected to be scaled between 0 and 1.

## Numerical Checks

- Osmotic pressure calculations use consistent gas-constant units.
- Homeostatic simulations use explicit Euler steps and prevent non-finite results.
- Growth fitting is performed in log space.
- Oxygen limitation is constrained between 0 and 1 for relative energy rate.
- Energy-budget calculations report mass/energy-balance residuals.
- Scoring functions validate unit-interval input fields.

## Reproducibility Checks

- Synthetic datasets are small and versioned.
- Model assumptions are documented in `docs/methodology.md`.
- SQL provenance records describe source, method, license, and uncertainty.
- Notebook scaffolds reproduce the main table calculations.

## Limitations

The validation checks are not substitutes for empirical quality control. Research, clinical, environmental, industrial, hydrological, or regulatory use would require stronger validation, calibration, sensitivity analysis, uncertainty propagation, domain review, and audit trails.
