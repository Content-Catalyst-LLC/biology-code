# Validation Notes

## Input Validation

- Time values must be non-negative.
- Growth counts must be positive for log-linear fitting.
- Carrying capacity must exceed initial abundance.
- Allele frequencies must be between 0 and 1.
- Biodiversity counts must be non-negative.
- Diversity calculations require positive total abundance.
- Sequences must be aligned and equal length for simple similarity scoring.
- Biological levels are descriptive scaffolds, not a hierarchy of causal reduction.

## Reproducibility Checks

- Synthetic datasets are versioned in `data/`.
- SQL schema records provenance and uncertainty.
- Code is deterministic.
- Notebook scaffolds reproduce the core calculations.
- Model assumptions are documented in `docs/methodology.md`.

## Limitations

The examples do not include stochastic growth, demographic structure, genetic drift, migration, selection, sequence alignment, phylogenetic tree-building, image analysis, or full systems-biology modeling.
