# Methodology Notes

## Purpose

The computational examples support genomics reasoning by translating expression matrices, variant summaries, sequence distance, nucleotide diversity, population structure, metagenomic abundance, functional potential, and provenance into transparent calculations.

## Core Methods

### Allele Frequency

p + q = 1

where p and q are allele frequencies.

### Expected Heterozygosity

H_e = 2pq

where p and q are allele frequencies.

### Nucleotide Diversity

pi = mean(2 p_i (1 - p_i))

where p_i is allele frequency at site i.

### FST-Style Differentiation

F_ST = (H_T - H_S) / H_T

where H_T is total expected heterozygosity and H_S is mean within-population heterozygosity.

### Expression Fold Change

log2FC = log2((E2 + epsilon) / (E1 + epsilon))

where E1 and E2 are expression values and epsilon is a small pseudocount.

### Sequence Difference

d = m / L

where m is mismatch count and L is sequence length.

### Jukes-Cantor Correction

d_JC = -3/4 ln(1 - 4d/3)

where d is observed sequence difference.

### PCA-Style Ordination

Expression or genotype matrices can be centered and decomposed with SVD to obtain low-dimensional sample coordinates.

### Metagenomic Functional Potential

Community abundance and gene-count features can be combined into transparent diagnostic scores, with strong caution that such scores are only screening devices.

## Interpretation

These workflows should be interpreted as educational computational genomics scaffolds, not calibrated sequencing, clinical-genomics, transcriptomics, metagenomics, variant-calling, or conservation-genomics models. Real applications require raw data QC, alignment, normalization, annotation, statistical testing, uncertainty analysis, and domain expertise.
