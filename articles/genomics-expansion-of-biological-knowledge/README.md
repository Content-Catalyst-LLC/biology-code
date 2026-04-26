# Genomics and the Expansion of Biological Knowledge

This article repository supports the Biology knowledge-series article:

**Genomics and the Expansion of Biological Knowledge**

The code distribution expands the article's compact R and Python examples into a fuller computational genomics workflow. It includes expression matrices, log2 fold change, PCA-style ordination, variant-matrix summaries, minor allele frequency, heterozygosity, missingness, nucleotide diversity, FST-style population structure, sequence-distance matrices, Jukes-Cantor correction, metagenomic abundance profiles, functional-potential scoring, SQL provenance structures, reproducible data files, and multi-language scientific-computing scaffolding.

## Repository Structure

- `python/` — variant matrix summaries, expression PCA, sequence distance, population structure, metagenomic profiles, and genomic condition scoring
- `r/` — expression matrix summaries, diversity and FST-style structure, sequence distance, and clustering scaffolds
- `julia/` — allele frequency, heterozygosity, diversity, distance, and expression calculations
- `fortran/` — compact genomics numerical kernels
- `rust/` — safe command-line genomic condition scoring utility
- `go/` — portable genomic condition scoring helper
- `c/` — allele frequency, heterozygosity, and sequence-distance computational kernel
- `cpp/` — comparative genomics scenario simulation
- `sql/` — expression observations, variant summaries, sequence records, metagenomic profiles, outputs, and provenance schema
- `docs/` — setup, methodology, and reproducibility notes
- `data/` — small reproducible example datasets
- `notebooks/` — notebook scaffold and workflow notes

## Scientific Focus

The workflows are designed to support transparent genomics reasoning:

1. Summarize genome-scale expression matrices.
2. Calculate log2 fold change and sample ordination.
3. Summarize variant matrices with allele frequency, MAF, heterozygosity, and missingness.
4. Calculate nucleotide diversity and FST-style population structure.
5. Build sequence-distance matrices with Jukes-Cantor correction.
6. Summarize metagenomic abundance and functional potential.
7. Score genomic condition examples.
8. Track data provenance and reproducibility.

These examples are educational scaffolds, not operational clinical-genomics, sequencing, variant-calling, transcriptomics, metagenomics, or conservation-genomics pipelines. Real applications require empirical data, quality control, statistical modeling, annotation, uncertainty analysis, and expert interpretation.
