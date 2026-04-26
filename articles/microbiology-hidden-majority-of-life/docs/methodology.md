# Methodology Notes

## Purpose

The computational examples support microbiology reasoning by translating growth, limitation, substrate use, environmental sensitivity, community recovery, condition indexing, and uncertainty into transparent calculations.

## Core Methods

### Exponential Growth

N(t) = N0 exp(rt)

where N0 is initial abundance, r is intrinsic growth rate, and t is time.

### Logistic Growth

dN/dt = rN(1 - N/K)

where K is effective carrying capacity.

### Monod Kinetics

mu(S) = mu_max S / (Ks + S)

where S is substrate concentration, mu_max is maximum growth rate, and Ks is the half-saturation constant.

### Substrate-Limited Growth

The Monod examples update abundance and substrate together:

dN = mu(S) N dt

dS = -dN / Y

where Y is a yield coefficient.

### Community Recovery

Community recovery after disturbance is represented as:

dB/dt = rB(1 - B/K) - mB + I(t)

where B is microbial biomass or functional abundance, r is recovery rate, K is carrying capacity, m is chronic stress or mortality, and I(t) is an intervention pulse.

### Condition Screening

The condition index combines functional richness, nitrification potential, denitrification balance, pathogen signal, and organic overload. It is an illustrative applied screening framework, not a substitute for direct process measurements.

## Interpretation

These workflows should be interpreted as educational computational microbiology scaffolds, not as calibrated clinical, wastewater, fermentation, or ecosystem models. Real applications require measured microbial abundance, substrate data, process rates, environmental covariates, uncertainty analysis, and domain expertise.
