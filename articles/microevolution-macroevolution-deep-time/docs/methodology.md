# Methodology Notes

## Purpose

The computational examples support evolutionary-scale reasoning by translating allele-frequency change, genotype expectations, drift, divergence, origination, extinction, and clade turnover into transparent calculations.

## Core Methods

### Allele Frequency

p + q = 1

where p and q are allele frequencies.

### Hardy-Weinberg Genotype Frequencies

p^2 + 2pq + q^2 = 1

where p^2, 2pq, and q^2 are expected genotype frequencies under Hardy-Weinberg assumptions.

### Selection Update

p' = (p^2 W_AA + p q W_Aa) / Wbar

where Wbar = p^2 W_AA + 2 p q W_Aa + q^2 W_aa.

### Migration

p' = (1 - m)p + m p_migrant

where m is migration fraction.

### Wright-Fisher Drift

X_(t+1) ~ Binomial(2N, p_t)

p_(t+1) = X_(t+1) / 2N

### Jukes-Cantor Distance

d_JC = -3/4 ln(1 - 4p/3)

where p is observed sequence difference.

### Birth-Death Turnover

r = lambda - mu

where lambda is origination rate and mu is extinction rate.

## Interpretation

These workflows should be interpreted as educational computational evolutionary-biology scaffolds, not calibrated population-genetic, phylogenetic, paleobiological, or conservation models. Real applications require empirical data, explicit model assumptions, uncertainty analysis, and domain expertise.
