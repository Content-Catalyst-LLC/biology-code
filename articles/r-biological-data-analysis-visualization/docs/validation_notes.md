# Validation Notes

## Input Validation

- Sample identifiers should be unique when each row is a unique sample.
- Required columns must be present.
- Numeric measurement values should parse correctly.
- Units should be explicit.
- QC flags should use controlled values: pass, review, fail.
- Treatment groups should be documented.
- Species count data should not contain negative counts.
- Dose-response data should not contain negative doses unless the design explicitly allows them.

## Analytical Checks

- Avoid treating technical replicates as biological replicates.
- Inspect missingness before filtering.
- Inspect batch and instrument fields before modeling.
- Plot individual observations when sample size is small.
- Report effect sizes and uncertainty, not only p-values.
- Avoid interpreting descriptive smooth curves as mechanistic models.
- Validate biological conclusions against study design.

## Reproducibility Checks

- Data files are stored in `data/`.
- Scripts are stored in `r/`, `python/`, and other language directories.
- Outputs are written to `outputs/`.
- SQL schema records samples, measurements, species counts, provenance, figures, and artifacts.
- Notebook scaffold reproduces core calculations.

## Limitations

This repository does not implement full Bioconductor workflows, generalized mixed models, survival analysis, Bayesian modeling, ordination, controlled-access data governance, or regulated laboratory information-management systems.
