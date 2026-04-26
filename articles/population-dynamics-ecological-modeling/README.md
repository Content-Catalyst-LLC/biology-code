# Population Dynamics and Ecological Modeling

This article repository supports the Biology knowledge-series article:

**Population Dynamics and Ecological Modeling**

The code distribution expands the article's compact R and Python examples into a fuller computational population ecology workflow. It includes stochastic logistic population simulations, harvest scenarios, quasi-extinction analysis, stage-structured projection matrices, eigenvalue growth estimation, sensitivity screening, metapopulation occupancy models, SQL provenance structures, reproducible data files, and multi-language scientific-computing scaffolding.

## Repository Structure

- `python/` — stage-structured projection, sensitivity screening, stochastic trajectories, and metapopulation occupancy
- `r/` — stochastic logistic growth, harvest scenarios, catastrophes, and quasi-extinction analysis
- `julia/` — stochastic logistic growth and metapopulation occupancy dynamics
- `fortran/` — compact logistic growth and stage-structured numerical kernels
- `rust/` — safe command-line population risk scoring utility
- `go/` — portable population persistence scoring helper
- `c/` — logistic growth and harvest computational kernel
- `cpp/` — stochastic population viability simulation
- `sql/` — populations, vital rates, stage matrices, scenarios, model runs, and provenance schema
- `docs/` — setup, methodology, and reproducibility notes
- `data/` — small reproducible example datasets
- `notebooks/` — notebook scaffold and workflow notes

## Scientific Focus

The workflows are designed to support transparent population ecology reasoning:

1. Simulate population growth under density dependence and harvest.
2. Estimate quasi-extinction risk across stochastic trajectories.
3. Project stage-structured populations using matrix models.
4. Evaluate sensitivity to changes in adult survival or other vital rates.
5. Track data provenance and reproducibility.

These examples are educational scaffolds, not operational conservation forecasts. Real applications require field data, species-specific parameter estimation, uncertainty analysis, spatial context, expert interpretation, and system-specific validation.
