# Methodology Notes

## Purpose

The computational examples support biological-method reasoning by translating observation, experiment, measurement, assay validation, sequence comparison, imaging summaries, and reproducible data structures into transparent workflows.

## Core Methods

### Exponential Growth

N(t) = N0 exp(r t)

### Doubling Time

td = log(2) / r

### Logistic Growth

dN/dt = rN(1 - N/K)

### Hill Dose-Response

E(c) = Emin + (Emax - Emin) / (1 + (EC50 / c)^n)

### Assay Sensitivity

Sensitivity = TP / (TP + FN)

### Assay Specificity

Specificity = TN / (TN + FP)

### Sequence Matching

Hamming distance counts mismatched aligned positions.

### Signal Quality Score

Q = w_s S + w_r R + w_c C - w_n N

where S is signal strength, R is reproducibility, C is control separation, and N is noise or uncertainty penalty.

## Interpretation

These workflows are educational and methodological scaffolds. They do not replace expert experimental design, assay validation, statistical review, clinical evaluation, or regulatory-grade quality systems.
