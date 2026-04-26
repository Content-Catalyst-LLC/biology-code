# Methodology Notes

## Purpose

The computational examples support quantitative cell-biology reasoning by translating cell proliferation, viability loss, membrane transport, cell-cycle transition, treatment response, and cell-condition scoring into transparent calculations.

## Core Methods

### Exponential Growth

N(t) = N0 exp(r t)

where N is cell abundance, N0 is initial abundance, r is growth rate, and t is time.

### Doubling Time

td = log(2) / r

### Logistic Growth

dN/dt = rN(1 - N/K)

where K is carrying capacity.

### Viability Decay

L(t) = L0 exp(-k t)

where L is viable cell count and k is loss rate.

### Membrane Flux

J = -D dC/dx

where J is flux, D is diffusion coefficient, and dC/dx is concentration gradient.

### Cell-Cycle Compartment Model

dG1/dt = 2 kM G2M - k1 G1

dS/dt = k1 G1 - k2 S

dG2M/dt = k2 S - kM G2M

### Cell-Condition Score

Q = sum_i w_i x_i

where x_i are scaled cellular-condition variables and w_i are explicit weights.

## Interpretation

These workflows are educational and methodological scaffolds, not calibrated clinical, diagnostic, pharmaceutical, toxicological, or regulatory models. Real applications require empirical data, assay validation, calibration, uncertainty analysis, quality control, and domain expertise.
