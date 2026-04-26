# Validation Notes

## Input Validation

- Time values must be non-negative.
- Growth rates, death rates, diffusion coefficients, and carrying capacities must be biologically plausible and non-negative where required.
- Carrying capacity must exceed initial abundance in logistic examples.
- SIR compartments should be non-negative and normalized or consistently scaled.
- Michaelis-Menten substrate concentrations must be non-negative and Km must be positive.
- Network edges must reference valid node labels.
- Stochastic simulations require fixed seeds for reproducibility.

## Numerical Checks

- Euler integration is transparent but not always stable. Smaller time steps reduce error.
- Research applications should use validated ODE/PDE solvers.
- Sensitivity analysis should include parameter ranges and uncertainty propagation.
- Stochastic simulations should be run across many replicates for inference.
- Reaction-diffusion scaffolds require careful boundary conditions and stability constraints.

## Reproducibility Checks

- Synthetic datasets are versioned in `data/`.
- SQL schema records provenance and uncertainty.
- Notebook scaffolds reproduce the core calculations.
- Scripts are deterministic where seeds are specified.
- Model assumptions are documented in `docs/methodology.md`.

## Limitations

The examples do not include Bayesian calibration, formal model selection, advanced PDE solvers, stiff ODE solvers, high-performance parallel simulation, empirical parameter estimation, or regulatory-grade validation.
