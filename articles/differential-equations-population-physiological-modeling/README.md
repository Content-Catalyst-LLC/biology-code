# Differential Equations in Population and Physiological Modeling

This article repository supports the Biology knowledge-series article:

**Differential Equations in Population and Physiological Modeling**

The code distribution expands the article's compact R and Python examples into a rigorous differential-equation modeling workflow. It includes exponential and logistic population growth, predator-prey systems, SIR epidemic dynamics, homeostatic physiological regulation, one- and two-compartment pharmacokinetic models, chemostat dynamics, reaction-diffusion scaffolds, numerical integration, equilibrium and stability summaries, sensitivity analysis, SQL provenance structures, validation notes, reproducible data files, and multi-language scientific-computing examples.

No university affiliation is implied by this repository. The design goal is advanced reproducible computational rigor: clear assumptions, modular code, transparent data structures, provenance, validation checks, uncertainty quantification, and reproducible workflows.

## Repository Structure

- `python/` — ODE core, logistic growth, predator-prey, SIR, homeostasis, pharmacokinetics, chemostat dynamics, reaction-diffusion scaffold, sensitivity analysis, and run-all workflow
- `r/` — logistic growth, homeostasis, predator-prey, SIR, pharmacokinetics, and chemostat workflows
- `julia/` — high-performance ODE kernels
- `fortran/` — numerical kernels for population and physiological models
- `rust/` — safe command-line dynamic-model summary utility
- `go/` — portable ODE helper
- `c/` — compact numerical ODE kernel
- `cpp/` — comparative biological dynamics scenario simulation
- `sql/` — model catalog, scenarios, parameters, outputs, and provenance schema
- `docs/` — setup, methodology, validation, and reproducibility notes
- `data/` — synthetic reproducible example datasets
- `notebooks/` — notebook scaffold and workflow notes

## Scientific Focus

The workflows are designed to support transparent differential-equation modeling in biology:

1. Model exponential and logistic population growth.
2. Simulate predator-prey ecological interaction.
3. Simulate SIR epidemic dynamics.
4. Model homeostatic return to set point.
5. Simulate one-compartment pharmacokinetic elimination.
6. Simulate chemostat biomass-substrate dynamics.
7. Prototype reaction-diffusion spatial dynamics.
8. Evaluate sensitivity to parameters and initial conditions.
9. Track provenance, assumptions, and limitations.

These examples are educational and methodological scaffolds. They are not clinical, regulatory, pharmacological, environmental compliance, conservation policy, diagnostic, or production biotechnology systems. Real applications require empirical calibration, validated numerical solvers, uncertainty analysis, domain expertise, and appropriate ethical or regulatory oversight.
