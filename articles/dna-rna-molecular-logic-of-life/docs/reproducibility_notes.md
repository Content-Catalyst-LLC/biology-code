# Reproducibility Notes

## Data

All example datasets in `data/` are synthetic and small. They demonstrate structure rather than represent real DNA, RNA, transcriptomic, clinical, ecological, or sequencing measurements.

## Provenance

The SQL schema includes fields for:

- sequence records
- transcript decay observations
- expression observations
- codon counts
- molecular condition sites
- model outputs
- data source
- analytical method
- license
- uncertainty notes

This supports transparent molecular biology workflows where results can be traced back to data sources and modeling assumptions.

## Randomness

The expression matrix examples set random seeds when synthetic data are generated. Future stochastic extensions should record seeds, sample sizes, parameter distributions, and assumptions.

## Limitations

The examples do not include:

- raw sequencing reads
- quality control
- read alignment
- transcript quantification
- differential expression testing
- multiple-comparison correction
- splice-aware modeling
- RNA secondary-structure prediction
- codon optimization
- clinical interpretation
- regulatory inference

Those extensions can be added as the repository grows.
