# Reproducibility Notes

## Data

All example datasets in `data/` are synthetic and small. They demonstrate computational structure rather than represent real clinical, cell-culture, imaging, toxicology, marine, ecological, or biotechnology measurements.

## Provenance

The SQL schema includes fields for:

- cell-count observations
- viability observations
- logistic growth scenarios
- membrane gradient scenarios
- cell-cycle scenarios
- treatment conditions
- cell-condition sites
- model outputs
- data source
- analytical method
- license
- uncertainty notes

## Randomness

The core examples are deterministic. Future stochastic extensions should record seeds, parameter distributions, sample sizes, assay metadata, instrument metadata, imaging metadata, and model versions.

## Limitations

The examples do not include:

- real microscopy segmentation
- single-cell RNA-seq preprocessing
- flow cytometry compensation
- pharmacodynamic calibration
- clinical interpretation
- toxicology reporting
- Bayesian uncertainty propagation
- validated assay quality-control workflows

Those extensions can be added as the repository grows.
