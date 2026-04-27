# Validation Notes

## Input Validation

- Experimental units must be defined before analysis.
- Treatment allocation should be recorded explicitly.
- Technical replicates must not be treated as independent biological replicates.
- Blocking variables should be measured before treatment assignment.
- Power simulation requires assumptions about effect size, variance, sample size, and decision threshold.
- Factorial designs require all factor combinations to be represented unless using fractional designs.
- Mixed-effects scaffolds require a clear grouping structure.

## Numerical Checks

- Normal approximations can be unstable for very small samples.
- Power estimates depend on assumed variation and effect size.
- Bootstrap intervals depend on representative sampling.
- Permutation tests require exchangeability under the null.
- ANOVA-style summaries require design assumptions to be checked.
- Mixed-effects models require specialized statistical libraries for production inference.

## Reproducibility Checks

- Synthetic datasets are versioned in `data/`.
- SQL schema records design metadata and provenance.
- Scripts use deterministic seeds where simulation occurs.
- Notebook scaffolds reproduce the core calculations.
- Model assumptions are documented in `docs/methodology.md`.

## Limitations

The examples do not include formal GLMM fitting, Bayesian hierarchical modeling, adaptive trial designs, survival analysis, regulatory trial reporting, animal protocol review, or production-grade clinical statistics.
