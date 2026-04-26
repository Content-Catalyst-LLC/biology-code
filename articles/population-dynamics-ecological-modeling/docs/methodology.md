# Methodology Notes

## Purpose

The computational examples support population ecology reasoning by translating article concepts into transparent calculations. The examples are intentionally compact so they can be inspected, adapted, and extended.

## Core Methods

### Exponential Growth

The simplest continuous growth model is:

dN/dt = rN

where N is population size and r is the intrinsic growth rate.

### Logistic Growth

The logistic model adds environmental limitation:

dN/dt = rN(1 - N/K)

where K is carrying capacity.

### Stochastic Population Viability

The R, Python, and C++ examples allow growth rate, carrying capacity, catastrophes, and harvest to vary across simulation runs. They estimate extinction risk and quasi-extinction risk.

### Stage-Structured Projection

The Python and Fortran examples use a matrix population model:

n(t+1) = A n(t)

where A contains fecundity, survival, and transition rates.

### Metapopulation Occupancy

The Python and Julia examples use a compact occupancy model:

p(t+1) = p(t) + c p(t)(1 - p(t)) - e p(t)

where p is occupied patch fraction, c is colonization, and e is extinction.

## Interpretation

These workflows should be interpreted as educational population-analysis scaffolds, not as operational population viability assessments. Real applications require species-specific data, detection correction, parameter estimation, spatial structure, uncertainty analysis, and expert interpretation.
