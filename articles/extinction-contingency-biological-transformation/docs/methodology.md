# Methodology Notes

## Purpose

The computational examples support extinction, contingency, and historical-biology reasoning by translating survivorship, hazard, stochastic survival, post-crisis recovery, trait vulnerability, and phylogenetic loss into transparent calculations.

## Core Methods

### Survivorship Proportion

S = N_survivors / N_initial

where N_initial is the number of lineages before an interval and N_survivors is the number remaining afterward.

### Extinction Proportion

E = 1 - S

where E is proportional loss.

### Exponential Survivorship

S(t) = exp(-lambda t)

where lambda is an effective extinction hazard and t is time.

### Logistic Post-Crisis Recovery

dN/dt = rN(1 - N/K)

where N is richness or recovering lineage count, r is recovery rate, and K is an effective ecological ceiling.

### Trait-Dependent Risk

R_i = w1(1 - G_i) + w2(1 - T_i) + w3 H_i

where G is geographic range breadth, T is trophic or ecological flexibility, H is habitat dependence or exposure, and weights determine the contribution of each component.

### Phylogenetic Loss

A simplified phylogenetic-loss fraction is:

L = lost_branch_length / total_branch_length

This is a toy structure for thinking about evolutionary history lost, not a complete phylogenetic diversity analysis.

## Interpretation

These workflows should be interpreted as educational computational extinction scaffolds, not calibrated paleobiological, conservation, or phylogenetic models. Real applications require empirical data, fossil sampling correction, phylogenetic inference, uncertainty analysis, and domain expertise.
