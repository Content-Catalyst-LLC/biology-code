# Reproducibility Notes

## Data

All example datasets in `data/` are synthetic and small. They demonstrate computational structure rather than represent real clinical, metabolomic, proteomic, genomic, lipidomic, ecological, or assay measurements.

## Provenance

The SQL schema includes fields for:

- biomolecular composition measurements
- sequence records
- enzyme assay conditions
- ligand-binding conditions
- polymerization examples
- biomolecular condition sites
- model outputs
- data source
- analytical method
- license
- uncertainty notes

## Randomness

The core examples are deterministic. Future stochastic extensions should record seeds, parameter distributions, sample sizes, assay metadata, instrument metadata, and model versions.

## Limitations

The examples do not include:

- real omics preprocessing
- mass spectrometry normalization
- sequencing quality control
- protein-structure prediction
- molecular docking
- pharmacokinetic modeling
- replicate assay uncertainty
- clinical interpretation
- regulatory reporting

Those extensions can be added as the repository grows.
