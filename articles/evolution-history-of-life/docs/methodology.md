# Methodology Notes

## Purpose

The computational examples support evolutionary reasoning by translating allele-frequency change, selection, mutation, migration, drift, sequence divergence, corrected distance, birth-death diversification, and transition documentation into transparent calculations.

## Core Methods

### Allele Frequencies

p + q = 1

where p and q are allele frequencies.

### Hardy-Weinberg Genotype Frequencies

p^2 + 2pq + q^2 = 1

where p^2, 2pq, and q^2 are expected genotype frequencies.

### Mean Fitness

wbar = p^2 w_AA + 2pq w_Aa + q^2 w_aa

where w_AA, w_Aa, and w_aa are genotype fitnesses.

### Selection Update

p' = (p^2 w_AA + p q w_Aa) / wbar

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

### Sequence Distance

d = m / L

where m is the number of mismatches and L is sequence length.

### Jukes-Cantor Distance

d_JC = -3/4 ln(1 - 4d/3)

where d is observed sequence difference.

### Net Diversification

r = lambda - mu

where lambda is origination or speciation rate and mu is extinction rate.

## Interpretation

These workflows should be interpreted as educational computational evolutionary-biology scaffolds, not calibrated population-genetic, phylogenetic, paleobiological, conservation, or genomic models. Real applications require empirical data, explicit model assumptions, uncertainty analysis, and domain expertise.
