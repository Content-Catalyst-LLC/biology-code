# Methodology Notes

## Purpose

The computational examples support signaling reasoning by translating receptor occupancy, cooperative response, second-messenger decay, pulse-driven dynamics, feedback control, quorum-sensing thresholds, and condition scoring into transparent calculations.

## Core Methods

### Receptor Occupancy

theta = L / (Kd + L)

where theta is receptor occupancy, L is ligand concentration, and Kd is the dissociation constant.

### Hill Response

R(L) = L^n / (K^n + L^n)

where R(L) is normalized response, K is the half-response level, and n is the Hill coefficient.

### Second-Messenger Decay

M(t) = M0 exp(-kt)

where M(t) is messenger abundance, M0 is initial abundance, k is decay constant, and t is time.

### Half-Life

t_1/2 = ln(2) / k

where t_1/2 is the half-life.

### Pulse-Driven Signaling

dS/dt = alpha I(t) - beta S

where S is pathway activity and I(t) is time-dependent input.

### Negative Feedback

dS/dt = alpha I(t) - beta S - gamma F S

dF/dt = delta S - epsilon F

where F is feedback inhibitor.

### Quorum Signal Accumulation

dQ/dt = aN - dQ

where Q is signal concentration, N is population density, a is production rate, and d is degradation or dilution.

## Interpretation

These workflows should be interpreted as educational computational signaling scaffolds, not calibrated pharmacology, systems-biology, clinical, synthetic-biology, or pathway-inference models. Real applications require empirical data, calibration, uncertainty analysis, and domain expertise.
