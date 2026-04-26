# Reproducibility Notes

## Data

All example datasets in `data/` are synthetic and small. They demonstrate structure rather than represent real sequencing, expression, variant, metagenomic, clinical, or conservation-genomic measurements.

## Provenance

The SQL schema includes fields for:

- expression observations
- variant summaries
- aligned sequences
- population allele frequencies
- metagenomic profiles
- genomic condition sites
- model outputs
- data source
- analytical method
- license
- uncertainty notes

This supports transparent genomics workflows where results can be traced back to data sources and modeling assumptions.

## Randomness

Python and R stochastic examples set random seeds. Future stochastic extensions should record seeds, parameter distributions, sample sizes, and assumptions.

## Limitations

The examples do not include:

- raw sequencing reads
- FASTQ quality control
- read alignment
- assembly
- gene annotation
- variant calling
- differential expression testing
- multiple-comparison correction
- taxonomic classification
- phylogenetic inference
- clinical interpretation

Those extensions can be added as the repository grows.
