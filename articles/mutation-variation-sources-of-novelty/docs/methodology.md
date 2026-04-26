# Methodology Notes

## Purpose

The computational examples support mutation-and-variation reasoning by translating mutation supply, sequence distance, nucleotide diversity, mutation spectra, mutation-selection balance, structural variation, and novelty conditions into transparent calculations.

## Core Methods

### Allele Frequencies

p + q = 1

where p and q are allele frequencies.

### Hardy-Weinberg Genotype Frequencies

p^2 + 2pq + q^2 = 1

where p^2, 2pq, and q^2 are expected genotype frequencies.

### Sequence Difference

d = m / L

where m is mismatch count and L is sequence length.

### Jukes-Cantor Distance

d_JC = -3/4 ln(1 - 4d/3)

where d is observed sequence difference.

### Expected Mutation Count

E[M] = n L mu

where n is number of transmitting genomes, L is genomic target length, and mu is per-site mutation rate.

### Poisson Mutation Count

P(M = k) = lambda^k exp(-lambda) / k!

where lambda = n L mu.

### Nucleotide Diversity

pi = mean(2 p_i (1 - p_i))

where p_i is allele frequency at site i under a biallelic approximation.

### Mutation-Selection Balance

q* ≈ sqrt(mu / s)

for a deleterious recessive allele under a classic approximation.

### Mutation-Selection-Drift

Selection updates allele frequencies through genotype fitness, recurrent mutation introduces new copies, and binomial sampling approximates drift in finite diploid populations.

## Interpretation

These workflows should be interpreted as educational computational mutation-and-variation scaffolds, not calibrated clinical genetics, conservation genomics, population-genomics, cancer-genomics, or variant-interpretation models. Real applications require empirical data, quality control, annotation, uncertainty analysis, and domain expertise.
