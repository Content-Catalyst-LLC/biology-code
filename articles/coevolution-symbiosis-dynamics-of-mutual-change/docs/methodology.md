# Methodology Notes

## Purpose

The computational examples support coevolution and symbiosis reasoning by translating reciprocal feedback, benefit-cost balance, interaction dependence, host-pathogen escalation, and relationship breakdown into transparent calculations.

## Core Methods

### Partner Frequency

p + q = 1

where p and q are alternative trait frequencies.

### Selection Update

p' = p Wp / Wbar

where Wp is the fitness of a type and Wbar is mean population fitness.

### Partner-Dependent Payoff

Wi = W0 + beta I

where Wi is partner-dependent performance, W0 is baseline performance, beta is interaction strength, and I is compatible partner prevalence or interaction intensity.

### Host-Symbiont Benefit-Cost Balance

Hnet = H0 + bS - cS

where Hnet is net host performance, H0 is baseline performance, S is symbiont prevalence or load, b is benefit, and c is cost.

### Network Dependency Score

Di = sum(wij rj)

where wij is interaction weight and rj is partner reliability.

## Interpretation

These workflows should be interpreted as educational computational coevolution scaffolds, not calibrated disease, ecological, phylogenetic, or conservation models. Real applications require empirical interaction data, environmental covariates, genomic evidence, phylogenetic context, and uncertainty analysis.
