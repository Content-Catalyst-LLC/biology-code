# Methodology Notes

## Purpose

The computational examples support heredity reasoning by translating inheritance ratios, genotype expectations, allele frequencies, recombination fractions, chi-square tests, quantitative trait variance, and condition scoring into transparent calculations.

## Core Methods

### Monohybrid Genotype Expectation

For Aa x Aa:

P(AA) = 1/4

P(Aa) = 1/2

P(aa) = 1/4

### Hardy-Weinberg Genotype Frequencies

p + q = 1

p^2 + 2pq + q^2 = 1

where p and q are allele frequencies.

### Expected Heterozygosity

H_e = 2pq

where p and q are allele frequencies.

### Chi-Square Goodness-of-Fit

chi^2 = sum((O_i - E_i)^2 / E_i)

where O_i is an observed count and E_i is an expected count.

### Recombination Fraction

r = recombinant gametes / total gametes

where recombinant gametes are gamete classes produced by crossing over between linked loci.

### Narrow-Sense Heritability

h^2 = V_A / V_P

where V_A is additive genetic variance and V_P is total phenotypic variance.

### Breeder's Equation

R = h^2 S

where R is response to selection, h^2 is narrow-sense heritability, and S is selection differential.

## Interpretation

These workflows should be interpreted as educational computational heredity scaffolds, not calibrated clinical-genetics, breeding, conservation-genomics, or population-genomics models. Real applications require empirical data, quality control, experimental design, uncertainty analysis, and domain expertise.
