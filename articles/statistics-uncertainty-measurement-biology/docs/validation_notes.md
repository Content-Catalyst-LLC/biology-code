# Validation Notes

## Input Validation

- Measurements must be numeric and linked to units where possible.
- Standard uncertainties must be non-negative.
- Calibration standards should span the relevant measurement range.
- Technical replicates must not be treated as independent biological replicates.
- Variance-component summaries require clear grouping structure.
- Bootstrap intervals depend on representative sampling.
- Error propagation requires an explicit measurement equation.
- Assay QC summaries require documented thresholds and controls.

## Numerical Checks

- Standard error should not be used to represent biological variation.
- Calibration extrapolation outside the standard range is risky.
- Root-sum-of-squares uncertainty assumes independent components.
- Measurement-error simulations are illustrative unless empirically calibrated.
- Mixed-effects scaffolds require specialized statistical libraries in production workflows.

## Reproducibility Checks

- Synthetic datasets are versioned in `data/`.
- SQL schema records provenance and uncertainty.
- Scripts are deterministic where random seeds are used.
- Notebook scaffolds reproduce the core calculations.
- Model assumptions are documented in `docs/methodology.md`.

## Limitations

The examples do not include full GLM/GLMM inference, Bayesian hierarchical modeling, regulatory assay validation, full metrology traceability, image segmentation, LIMS integration, or production-grade quality systems.
