# Validation Notes

The repository includes simple validation checks appropriate for an educational scientific-computing scaffold:

## Input Validation

- Time values must be non-negative.
- Abundance values must be positive for log-linear growth fitting.
- Substrate input must be positive for yield calculations.
- Allocation components must not exceed input without being flagged.
- Condition-score variables are expected to be scaled between 0 and 1.
- Toy flux-balance rows are filtered by mass-balance tolerance.

## Numerical Checks

- Exponential growth fitting is performed on log-transformed abundance.
- Doubling time is calculated only when estimated growth rate is positive.
- Monod growth is constrained to non-negative substrate.
- Logistic growth uses positive carrying capacity.
- Toy flux-balance candidates report explicit precursor-balance residuals.

## Reproducibility Checks

- Synthetic datasets are small and versioned.
- Model assumptions are documented in `docs/methodology.md`.
- SQL provenance records describe source, method, license, and uncertainty.
- Notebook scaffolds reproduce the main table calculations.

## Limitations

The validation checks are not substitutes for empirical quality control. Research, clinical, environmental, industrial, or regulatory use would require stronger validation, calibration, sensitivity analysis, uncertainty propagation, domain review, and audit trails.
