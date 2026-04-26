# Validation Notes

## Input Validation

- Time values must be non-negative.
- Cell or organism counts must be positive for log-linear fitting.
- Carrying capacity must exceed initial abundance for logistic examples.
- Assay counts must be non-negative.
- Sequences must be aligned and equal length for Hamming distance.
- Imaging features must be non-negative where biologically appropriate.
- Signal scoring inputs should be scaled between 0 and 1.

## Reproducibility Checks

- Synthetic datasets are versioned in `data/`.
- SQL schema records provenance and uncertainty.
- Code is deterministic.
- Notebook scaffolds reproduce the core calculations.
- Model assumptions are documented in `docs/methodology.md`.

## Limitations

The examples do not include full experimental design, mixed-effects modeling, Bayesian inference, validated diagnostic pipelines, regulatory QC, laboratory information management, or production-grade biotechnology automation.
