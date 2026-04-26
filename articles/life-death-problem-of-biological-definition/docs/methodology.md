# Methodology Notes

## Purpose

The computational examples support reasoning about life, death, dormancy, viruses, and borderline biological definition by translating measurable processes into transparent calculations.

## Core Methods

### Exponential Growth

N(t) = N0 exp(r t)

### Viability Decay

L(t) = L0 exp(-k t)

where L is viable abundance and k is a viability-loss rate.

### Survival Probability

S(t) = exp(-h t)

where h is a constant hazard rate.

### Dormancy Loss and Reactivation

dD/dt = -(m + alpha)D

dA/dt = alpha D

where D is dormant abundance, A is activated abundance, m is dormancy mortality, and alpha is reactivation rate.

### Host-Virus Dynamics

dT/dt = -beta T V

dI/dt = beta T V - delta I

dV/dt = p I - c V

where T is target-cell abundance, I is infected-cell abundance, V is free-virus abundance, beta is infection rate, delta is infected-cell loss rate, p is virion production rate, and c is viral clearance rate.

### Heuristic Life-Criteria Score

Q = sum_i w_i x_i

where x_i are scaled criteria and w_i are explicit weights.

## Interpretation

These workflows do not define life universally. They formalize processes that matter to definitions of life: viability, persistence, reproduction, dormancy, host dependence, mortality, and borderline classification. The models are educational and methodological scaffolds, not clinical, diagnostic, regulatory, or astrobiology mission tools.
