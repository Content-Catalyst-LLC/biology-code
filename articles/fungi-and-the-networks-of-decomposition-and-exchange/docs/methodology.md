# Methodology Notes

## Purpose

The computational examples support fungal-biology reasoning by translating decomposition, environmental forcing, fungal guild effects, biomass recovery, network fragmentation, and restoration screening into transparent calculations.

## Core Methods

### Decomposition Kinetics

A first-order decomposition model is:

dM/dt = -kM

with solution:

M(t) = M0 exp(-kt)

The expanded model uses:

dM/dt = -k0 fT(T) fW(W) fQ(Q) M

where fT is a temperature modifier, fW is a moisture modifier, and fQ is a substrate-quality modifier.

### Q10 Temperature Response

The temperature modifier is:

fT(T) = Q10 ^ ((T - Tref) / 10)

### Moisture Limitation

The moisture modifier is modeled as a unimodal response, where activity declines under both drought and saturation.

### Fungal Guild Effects

Guild multipliers distinguish simplified effects of white-rot, brown-rot, mixed saprotroph, and disturbance-simplified assemblages.

### Biomass Recovery

Fungal biomass recovery uses a logistic growth model with chronic turnover and optional inoculation pulse:

dB/dt = rB(1 - B/K) - mB + I(t)

### Network Efficiency

Global efficiency is calculated from shortest path distances:

EG = 1 / (n(n - 1)) sum_{i != j} 1 / dij

This translates structural fragmentation into transport-efficiency change.

## Interpretation

These workflows should be interpreted as educational computational fungal-biology scaffolds, not as calibrated ecosystem forecasts. Real applications require measured litter chemistry, environmental time series, fungal community data, trait validation, uncertainty analysis, and field calibration.
