# Methodology Notes

## Purpose

The computational examples support developmental-biology reasoning by translating growth, differentiation, positional information, pattern formation, and state transitions into transparent calculations.

## Core Methods

### Exponential Growth

N(t) = N0 exp(rt)

where N(t) is cell number, N0 is initial cell number, r is growth rate, and t is time.

### Doubling Time

td = ln(2) / r

where td is doubling time and r is growth rate.

### Logistic Growth

dN/dt = rN(1 - N/K)

where K is a constraint or carrying parameter.

### Two-State Differentiation

dP/dt = -kP

dD/dt = kP

where P is the progenitor compartment, D is the differentiated compartment, and k is the transition rate.

### Branching Differentiation

dP/dt = -(k1 + k2)P

dD1/dt = k1P

dD2/dt = k2P

where one progenitor compartment feeds two differentiated lineages.

### Morphogen Thresholding

fate = threshold(C(x))

where C(x) is morphogen concentration at position x.

### Reaction-Diffusion Patterning

du/dt = Du Laplacian(u) + f(u, v)

dv/dt = Dv Laplacian(v) + g(u, v)

where u and v are interacting patterning variables.

### State Transition

x_(t+1) = x_t P

where x_t is a developmental state distribution and P is a transition matrix.

## Interpretation

These workflows should be interpreted as educational computational developmental-biology scaffolds, not calibrated embryology, organoid, regenerative-medicine, clinical, or image-analysis models. Real applications require empirical data, experimental design, normalization, uncertainty analysis, and domain expertise.
