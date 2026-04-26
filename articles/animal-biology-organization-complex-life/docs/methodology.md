# Methodology Notes

## Purpose

The computational examples support animal-biology reasoning by translating body size, metabolic demand, population recovery, survival, stage structure, and conservation condition into transparent calculations.

## Core Methods

### Allometric Scaling

A common metabolic scaling form is:

B = B0 M^(3/4)

where B is metabolic rate, B0 is a normalization constant, and M is body mass.

### Logistic Population Growth

Population recovery is represented as:

dN/dt = rN(1 - N/K)

where N is abundance, r is intrinsic growth rate, and K is carrying capacity.

### Survival and Hazard

A simple survival model is:

S(t) = exp(-lambda t)

where lambda is effective hazard.

### Stage-Structured Projection

A compact juvenile-adult projection is:

n(t + 1) = A n(t)

where A is a stage projection matrix and n(t) is the stage-abundance vector.

### Condition Screening

The animal condition score combines habitat quality, food availability, disease pressure, heat stress, reproductive support, and movement connectivity. It is an illustrative screening framework, not a substitute for field demographic analysis.

## Interpretation

These workflows should be interpreted as educational computational animal-biology scaffolds, not calibrated management models. Real applications require species-specific life history, field data, demographic uncertainty, spatial context, and expert interpretation.
