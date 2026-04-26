# Reproducibility Notes

## Data

All example datasets in `data/` are synthetic and small. They demonstrate structure rather than represent real expression, methylation, chromatin accessibility, single-cell, or clinical measurements.

## Provenance

The SQL schema includes fields for:

- expression time courses
- methylation observations
- expression/accessibility comparisons
- regulatory switching scenarios
- cell-state transition records
- epigenetic condition sites
- model outputs
- data source
- analytical method
- license
- uncertainty notes

This supports transparent epigenetic workflows where results can be traced back to data sources and modeling assumptions.

## Randomness

The Python and R examples are deterministic unless otherwise stated. Future stochastic extensions should record seeds, parameter distributions, and assumptions.

## Limitations

The examples do not include:

- raw sequencing reads
- alignment
- peak calling
- methylation calling
- single-cell normalization
- batch correction
- statistical testing
- multiple-comparison correction
- causal regulatory inference
- chromatin-state segmentation
- trajectory inference with real cells
- clinical interpretation

Those extensions can be added as the repository grows.
