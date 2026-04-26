# Reproducibility Notes

## Data

All example datasets in `data/` are synthetic and small. They demonstrate computational structure rather than represent real clinical, microscopy, imaging, ecological, cell-culture, or diagnostic measurements.

## Provenance

The SQL schema includes fields for:

- compartment inventory
- membrane transport observations
- organelle morphometry observations
- compartment-flux scenarios
- organelle network edges
- cellular architecture condition sites
- model outputs
- data source
- analytical method
- license
- uncertainty notes

## Randomness

The core examples are deterministic. Future stochastic extensions should record seeds, parameter distributions, sample sizes, instrument metadata, segmentation parameters, and model versions.

## Limitations

The examples do not include:

- real image segmentation
- microscopy calibration
- object detection
- uncertainty propagation
- photobleaching correction
- 3D volume reconstruction
- live-cell tracking
- organelle contact-site inference
- clinical interpretation
- diagnostic pathology workflows

Those extensions can be added as the repository grows.
