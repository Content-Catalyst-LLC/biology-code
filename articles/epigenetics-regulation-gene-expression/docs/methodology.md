# Methodology Notes

## Purpose

The computational examples support epigenetic and gene-expression reasoning by translating transcript decay, production-decay dynamics, regulatory-state switching, methylation fractions, accessibility changes, differential expression, and cell-state transitions into transparent calculations.

## Core Methods

### Transcript Decay

m(t) = m0 exp(-kt)

where m(t) is transcript abundance, m0 is initial abundance, and k is the decay constant.

### Transcript Half-Life

t_1/2 = ln(2) / k

where t_1/2 is the estimated transcript half-life.

### Production-Decay Dynamics

dm/dt = alpha(t) - beta m

where alpha(t) is time-dependent effective production and beta is degradation.

### Two-State Regulatory Switching

dP_on/dt = k_on(1 - P_on) - k_off P_on

where P_on is probability of the active state.

### Methylation Fraction

f_meth = M / (M + U)

where M is methylated count and U is unmethylated count.

### Expression Fold Change

log2FC = log2((E_treated + epsilon) / (E_control + epsilon))

where E is expression and epsilon is a small pseudocount.

### Accessibility Change

Delta A = A_treated - A_control

where A is accessibility.

### Cell-State Transition

x_(t+1) = x_t P

where x_t is a cell-state distribution and P is a transition matrix.

## Interpretation

These workflows should be interpreted as educational computational epigenetics scaffolds, not calibrated clinical, epigenomic, single-cell, regulatory-network, or environmental models. Real applications require empirical assay design, normalization, batch correction, uncertainty analysis, and domain expertise.
