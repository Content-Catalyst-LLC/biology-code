# Validation Notes

## Input Validation

- Time steps must be positive.
- State variables should remain biologically interpretable and non-negative where appropriate.
- Half-saturation constants must be positive.
- Hill coefficients should be positive.
- Feedback strengths and degradation rates should be non-negative where required.
- Delay values must be non-negative.
- Carrying capacity should be positive.
- Sensitivity analysis requires nonzero baseline outputs and parameter values.

## Numerical Checks

- Euler integration is transparent but can be inaccurate or unstable.
- Delayed feedback models require careful time-step selection.
- Positive-feedback systems may be sensitive to initial conditions.
- Hill functions with large coefficients can create sharp transitions.
- Bistability claims require more than simulation from a few initial conditions.
- Research applications should use validated solvers and empirical calibration.

## Reproducibility Checks

- Synthetic datasets are versioned in `data/`.
- SQL schema records provenance and uncertainty.
- Scripts are deterministic.
- Notebook scaffolds reproduce the core calculations.
- Model assumptions are documented in `docs/methodology.md`.

## Limitations

The examples do not include formal bifurcation analysis, Bayesian parameter inference, stochastic differential equations, mechanistic pathway calibration, formal control-theory proofs, or production-grade biomedical/biotechnology workflows.
