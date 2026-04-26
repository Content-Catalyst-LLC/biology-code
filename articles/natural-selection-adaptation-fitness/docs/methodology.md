# Methodology Notes

## Purpose

The computational examples support natural-selection reasoning by translating relative fitness, genotype-specific selection, mean fitness, quantitative trait response, selection-drift dynamics, variable environments, and allele-frequency time series into transparent calculations.

## Core Methods

### Allele Frequencies

p + q = 1

where p and q are allele frequencies.

### Hardy-Weinberg Genotype Frequencies

p^2 + 2pq + q^2 = 1

where p^2, 2pq, and q^2 are expected genotype frequencies.

### Relative Fitness

w_i = 1 - s_i

where s_i is the selection coefficient against genotype or phenotype i.

### Mean Fitness

wbar = p^2 w_AA + 2pq w_Aa + q^2 w_aa

where w_AA, w_Aa, and w_aa are genotype fitnesses.

### Selection Update

p' = (p^2 w_AA + p q w_Aa) / wbar

where p' is the next-generation allele frequency after selection.

### Quantitative Trait Selection

R = h^2 S

where R is response to selection, h^2 is narrow-sense heritability, and S is the selection differential.

### Wright-Fisher Sampling After Selection

X_(t+1) ~ Binomial(2N, p_selected)

p_(t+1) = X_(t+1) / 2N

## Interpretation

These workflows should be interpreted as educational computational selection scaffolds, not calibrated conservation, biomedical, genomic, or field-selection models. Real applications require empirical fitness estimates, environmental context, uncertainty analysis, and domain expertise.
