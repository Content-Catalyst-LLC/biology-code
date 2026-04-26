# Methodology Notes

## Purpose

The computational examples support population-genetic reasoning by translating allele frequency, genotype frequency, expected heterozygosity, selection, mutation, migration, drift, and population structure into transparent calculations.

## Core Methods

### Allele Frequencies

p + q = 1

where p and q are allele frequencies.

### Hardy-Weinberg Genotype Frequencies

p^2 + 2pq + q^2 = 1

where p^2, 2pq, and q^2 are expected genotype frequencies.

### Expected Heterozygosity

He = 2pq

where He is expected heterozygosity at a two-allele locus.

### Mean Fitness

Wbar = p^2 W_AA + 2pq W_Aa + q^2 W_aa

where W_AA, W_Aa, and W_aa are genotype fitnesses.

### Selection Update

p' = (p^2 W_AA + pq W_Aa) / Wbar

where p' is the next-generation allele frequency after selection.

### Mutation Update

p' = p(1 - mu) + q nu

where mu is forward mutation and nu is reverse mutation.

### Migration Update

p' = (1 - m)p + m p_migrant

where m is migrant fraction and p_migrant is source-population allele frequency.

### Wright-Fisher Drift

X_(t+1) ~ Binomial(2N, p_t)

p_(t+1) = X_(t+1) / 2N

### FST-Style Structure

FST = (HT - HS) / HT

where HT is total expected heterozygosity and HS is mean within-population expected heterozygosity.

## Interpretation

These workflows should be interpreted as educational computational population-genetics scaffolds, not calibrated conservation, biomedical, or genomic inference models. Real applications require empirical sampling, model checking, quality control, uncertainty analysis, and domain expertise.
