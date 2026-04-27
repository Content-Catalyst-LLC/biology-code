# Validation Notes

## Input Validation

- Time steps must be positive.
- State variables should remain biologically interpretable and non-negative where appropriate.
- Growth, mortality, clearance, dilution, recovery, and diffusion rates must be non-negative when required.
- Carrying capacity should exceed initial population in logistic examples.
- Chemostat yield and substrate constants must be positive.
- Pharmacokinetic clearance rates must be positive.
- Reaction-diffusion stability depends on grid spacing and time step.

## Numerical Checks

- Euler integration is transparent but can be inaccurate or unstable.
- Research applications should use validated adaptive ODE solvers.
- Stiff physiological or biochemical systems require stiff solvers.
- PDE models require careful boundary conditions and stability diagnostics.
- Parameter sensitivity should be inspected before interpretation.
- Model outputs should be compared against empirical data before use in inference.

## Reproducibility Checks

- Synthetic datasets are versioned in `data/`.
- SQL schema records provenance and uncertainty.
- Scripts are deterministic.
- Notebook scaffolds reproduce the core calculations.
- Model assumptions are documented in `docs/methodology.md`.

## Limitations

The examples do not include Bayesian parameter inference, formal identifiability analysis, stiff ODE solvers, adaptive Runge-Kutta methods, full PDE solvers, high-performance ensemble simulation, or validated clinical/pharmacological workflows.
