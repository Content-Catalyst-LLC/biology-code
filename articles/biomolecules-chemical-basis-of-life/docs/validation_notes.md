# Validation Notes

The repository includes simple validation checks appropriate for an educational scientific-computing scaffold.

## Input Validation

- Concentrations must be non-negative.
- Vmax must be non-negative.
- Km and Kd must be positive.
- Molecular masses must be non-negative.
- Sequence strings must contain expected alphabet characters.
- Composition totals must be positive before fractions are calculated.
- Condition-score variables are expected to be scaled between 0 and 1.

## Numerical Checks

- Kinetic and binding curves are constrained to non-negative inputs.
- Sequence-feature extraction reports lengths and composition fractions.
- Biomolecular composition summaries report total mass and fractions.
- Polymerization mass balance explicitly reports estimated water-loss terms.
- Scoring functions validate unit-interval input fields.

## Reproducibility Checks

- Synthetic datasets are small and versioned.
- Model assumptions are documented in `docs/methodology.md`.
- SQL provenance records describe source, method, license, and uncertainty.
- Notebook scaffolds reproduce the main table calculations.

## Limitations

The validation checks are not substitutes for empirical quality control. Research, clinical, structural, pharmacological, or regulatory use would require stronger validation, calibration, sensitivity analysis, uncertainty propagation, domain review, and audit trails.
