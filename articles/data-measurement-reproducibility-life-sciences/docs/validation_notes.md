# Validation Notes

## Input Validation

- Sample identifiers should be unique.
- Required columns must be present.
- Measurement units must be explicit.
- QC flags should use controlled values such as pass, review, and fail.
- Missing values should be represented consistently.
- Provenance records should connect inputs, operations, and outputs.
- Data dictionaries should define variables, units, and allowable values.
- Uncertainty components should be non-negative.
- Artifact manifests should include roles and checksums when possible.

## Numerical Checks

- Coefficient of variation is unstable when the mean is close to zero.
- Standard error depends on sample size and distributional assumptions.
- Expanded uncertainty depends on the chosen coverage factor.
- QC pass rate depends on predefined criteria.
- Missingness may be nonrandom and should not be treated as harmless by default.

## Reproducibility Checks

- Synthetic datasets are versioned in `data/`.
- SQL schema records provenance, artifacts, QC flags, and uncertainty components.
- Scripts are deterministic.
- Notebook scaffolds reproduce the core calculations.
- Model assumptions are documented in `docs/methodology.md`.

## Limitations

The examples do not include protected health information workflows, regulated clinical validation, formal electronic lab notebook systems, real repository deposition, ontology integration, container builds, workflow-manager execution, or full FAIR metadata automation.
