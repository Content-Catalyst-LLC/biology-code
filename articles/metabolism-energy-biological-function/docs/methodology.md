# Methodology Notes

## Purpose

The computational examples support metabolism and energy-flow reasoning by translating growth, yield, substrate limitation, oxygen consumption, energy allocation, pathway bottlenecks, toy flux-balance logic, and condition scoring into transparent calculations.

## Core Methods

### Exponential Growth

N(t) = N0 exp(r t)

where N0 is initial abundance, r is per-capita growth rate, and t is time.

### Doubling Time

td = ln(2) / r

where td is doubling time and r is exponential growth rate.

### Logistic Growth

dN/dt = r N (1 - N / K)

where K is carrying capacity.

### Monod Substrate Limitation

mu(S) = mu_max S / (Ks + S)

where mu is substrate-dependent growth rate, mu_max is maximum growth rate, S is substrate concentration, and Ks is half-saturation constant.

### Biomass Yield

Yxs = delta_X / delta_S

where delta_X is biomass gained and delta_S is substrate consumed.

### Allocation Balance

S_input = S_growth + S_maintenance + S_product + S_loss

### Diffusive Flux

J = -D dC/dx

where J is flux, D is diffusion coefficient, and dC/dx is concentration gradient.

### Toy Flux-Balance Constraint

S v = 0

where S is a stoichiometric matrix and v is a vector of reaction fluxes.

## Interpretation

These workflows should be interpreted as educational and methodological scaffolds, not calibrated clinical, environmental, industrial, or genome-scale metabolic models. Real applications require empirical data, uncertainty analysis, calibration, quality control, and domain expertise.
