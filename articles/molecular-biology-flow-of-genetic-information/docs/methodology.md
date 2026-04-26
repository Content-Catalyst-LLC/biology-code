# Methodology Notes

## Purpose

The computational examples support molecular-biology reasoning by translating transcript decay, production-decay dynamics, sequence distance, GC content, codon usage, translation, expression fold change, mutation-rate estimation, and provenance into transparent calculations.

## Core Methods

### Transcript Decay

m(t) = m0 exp(-kt)

where m(t) is transcript abundance, m0 is initial abundance, k is the decay constant, and t is time.

### Transcript Half-Life

t_1/2 = ln(2) / k

where t_1/2 is transcript half-life.

### Production-Decay Dynamics

dm/dt = alpha(t) - beta m

where alpha(t) is time-dependent effective production and beta is degradation.

### Expression Fold Change

log2FC = log2((E2 + epsilon) / (E1 + epsilon))

where E1 and E2 are expression values and epsilon is a small pseudocount.

### Sequence Difference

d = m / L

where m is mismatch count and L is sequence length.

### Jukes-Cantor Correction

d_JC = -3/4 ln(1 - 4d/3)

where d is observed sequence difference.

### GC Fraction

GC = (G + C) / (A + T + G + C)

For RNA, U replaces T.

### Codon Frequency

f_c = n_c / total_codons

where n_c is the count of codon c.

### Mutation Rate

mu = m / (N * L * g)

where m is observed mutations, N is genomes or individuals observed, L is sites surveyed, and g is generations or replication cycles.

### PCA-Style Ordination

Expression matrices can be log-transformed, centered, and decomposed with SVD to obtain low-dimensional sample coordinates.

## Interpretation

These workflows should be interpreted as educational computational molecular-biology scaffolds, not calibrated sequencing, transcriptomic, clinical, diagnostic, phylogenetic, or regulatory-genomics models. Real applications require empirical data, quality control, annotation, uncertainty analysis, and domain expertise.
