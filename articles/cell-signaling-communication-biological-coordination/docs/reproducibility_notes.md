# Reproducibility Notes

## Data

All example datasets in `data/` are synthetic and small. They demonstrate structure rather than represent real receptor, pharmacological, calcium-imaging, phosphoproteomic, single-cell, microbial, ecological, or clinical measurements.

## Provenance

The SQL schema includes fields for:

- receptor response observations
- signaling decay traces
- pulse-feedback dynamics
- quorum-sensing observations
- pathway activation summaries
- signaling condition sites
- model outputs
- data source
- analytical method
- license
- uncertainty notes

This supports transparent signaling workflows where results can be traced back to data sources and modeling assumptions.

## Randomness

The examples are deterministic. Future stochastic extensions should record seeds, sample sizes, parameter distributions, and assumptions.

## Limitations

The examples do not include:

- parameter fitting with confidence intervals
- Bayesian inference
- experimental assay normalization
- single-cell variability
- pathway topology inference
- phosphoproteomics
- calcium-trace denoising
- ligand-receptor multi-state kinetics
- spatial diffusion
- stochastic chemical kinetics
- clinical interpretation

Those extensions can be added as the repository grows.
