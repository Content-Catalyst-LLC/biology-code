# Validation Notes

The repository includes simple validation checks appropriate for an educational scientific-computing scaffold.

## Input Validation

- Time values must be non-negative.
- Cell counts must be positive for log-linear growth and viability fitting.
- Growth rates, death rates, diffusion coefficients, and transition rates must be non-negative unless explicitly modeling decline.
- Carrying capacity must exceed initial cell count in logistic examples.
- Cell-cycle fractions must be non-negative.
- Condition-score variables are expected to be scaled between 0 and 1.

## Numerical Checks

- Growth fitting is performed in log space.
- Doubling time is calculated only when growth rate is positive.
- Viability half-life is calculated only when loss rate is positive.
- Logistic growth remains bounded by carrying capacity.
- Cell-cycle simulations prevent negative compartments.
- Scoring functions validate unit-interval input fields.

## Reproducibility Checks

- Synthetic datasets are small and versioned.
- Model assumptions are documented in `docs/methodology.md`.
- SQL provenance records describe source, method, license, and uncertainty.
- Notebook scaffolds reproduce the main table calculations.

## Limitations

The validation checks are not substitutes for empirical quality control. Research, clinical, pharmaceutical, toxicological, biotechnology, environmental, or regulatory use would require stronger validation, calibration, sensitivity analysis, uncertainty propagation, domain review, and audit trails.
