# Reproducibility Notes

## Data

All example datasets in `data/` are synthetic and small. They demonstrate structure rather than represent real embryological, plant-developmental, organoid, stem-cell, or developmental imaging measurements.

## Provenance

The SQL schema includes fields for:

- developmental growth observations
- lineage split scenarios
- morphogen-gradient observations
- state transition matrix records
- developmental condition sites
- model outputs
- data source
- analytical method
- license
- uncertainty notes

This supports transparent developmental workflows where results can be traced back to data sources and modeling assumptions.

## Randomness

The reaction-diffusion Python example sets a random seed. Future stochastic extensions should record seeds, parameter distributions, and assumptions.

## Limitations

The examples do not include:

- real microscopy images
- segmentation workflows
- lineage-tracing barcodes
- single-cell RNA-seq normalization
- pseudotime inference
- spatial transcriptomics
- organoid quality control
- experimental perturbation analysis
- biomechanical tissue simulation
- formal developmental toxicity assessment

Those extensions can be added as the repository grows.
