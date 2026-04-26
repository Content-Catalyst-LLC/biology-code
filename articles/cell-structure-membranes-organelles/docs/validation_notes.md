# Validation Notes

The repository includes simple validation checks appropriate for an educational scientific-computing scaffold:

## Input Validation

- Cell radius must be positive.
- Surface area and volume must be positive.
- Concentrations must be finite.
- Permeability and diffusion coefficients must be non-negative.
- Cell area must exceed zero for organelle-density calculations.
- Organelle area fractions are expected to be between 0 and 1.
- Condition-score variables are expected to be scaled between 0 and 1.

## Numerical Checks

- Surface-area-to-volume calculations are compared against analytical formulas.
- Compartment flux simulations prevent negative concentrations.
- Organelle fractions are calculated relative to cell area.
- Network summaries report both degree and weighted degree.
- Scoring functions validate unit-interval input fields.

## Reproducibility Checks

- Synthetic datasets are small and versioned.
- Model assumptions are documented in `docs/methodology.md`.
- SQL provenance records describe source, method, license, and uncertainty.
- Notebook scaffolds reproduce the main table calculations.

## Limitations

The validation checks are not substitutes for empirical quality control. Research, clinical, imaging, environmental, industrial, or regulatory use would require stronger validation, calibration, segmentation review, sensitivity analysis, uncertainty propagation, domain review, and audit trails.
