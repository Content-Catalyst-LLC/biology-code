# Validation Notes

## Input Validation

- Time values must be non-negative.
- Growth counts must be positive for log-linear fitting.
- Carrying capacity must exceed initial abundance.
- Allele frequencies must be between 0 and 1.
- Fitness values must be non-negative.
- Sequences must be aligned and equal length for simple similarity scoring.
- Historical milestone years are used for display and grouping, not causal inference.

## Reproducibility Checks

- Synthetic datasets are versioned in `data/`.
- SQL schema records provenance and uncertainty.
- Code is deterministic.
- Notebook scaffolds reproduce the core calculations.
- Model assumptions are documented in `docs/methodology.md`.

## Limitations

The examples do not include Bayesian inference, stochastic simulations, demographic structure, mutation-selection balance, migration, drift, linkage, epistasis, phylogenetic tree-building, or full sequence alignment.
