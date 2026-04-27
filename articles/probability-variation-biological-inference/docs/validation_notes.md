# Validation Notes

## Input Validation

- Trial counts must be non-negative.
- Successes cannot exceed trials.
- Probabilities must lie between 0 and 1.
- Bootstrap data must have enough observations to resample.
- Permutation tests require exchangeable observations under the null.
- Power simulations require explicit assumptions about effect size, variance, sample size, and threshold.
- Bayesian priors should be justified and sensitivity-tested.
- Multiple-testing workflows should distinguish exploratory screening from confirmatory inference.

## Numerical Checks

- Normal approximations can be poor for small n or extreme probabilities.
- Exact intervals or Bayesian intervals may be preferable in sparse data.
- Bootstrap intervals depend on sample representativeness.
- Permutation p-values depend on the random seed and number of permutations.
- Power estimates require many simulations for stability.
- False-discovery control depends on the number and dependence structure of tests.

## Reproducibility Checks

- Synthetic datasets are versioned in `data/`.
- SQL schema records provenance and uncertainty.
- Scripts use deterministic seeds where simulation occurs.
- Notebook scaffolds reproduce the core calculations.
- Model assumptions are documented in `docs/methodology.md`.

## Limitations

The examples do not include full generalized linear modeling, hierarchical Bayesian modeling, mixed-effects modeling, causal inference, survival analysis, phylogenetic comparative methods, single-cell workflows, or production-grade statistical pipelines.
