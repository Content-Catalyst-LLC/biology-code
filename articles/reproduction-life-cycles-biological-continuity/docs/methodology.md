# Methodology Notes

## Purpose

The computational examples support reproductive-biology reasoning by translating continuity, life-cycle structure, stage transitions, reproductive investment, and environmental stress into transparent calculations.

## Core Methods

### Generational Replacement

A simple generational replacement model is:

N(t+1) = R0 N(t)

where R0 is the net reproductive multiplier.

### Stage-Structured Projection

The main life-cycle model uses:

n(t+1) = A n(t)

where n is the stage abundance vector and A is a projection matrix with fecundity, survival, and transition values.

### Dominant Eigenvalue

The dominant eigenvalue of the projection matrix estimates asymptotic growth under fixed matrix conditions.

### Stable Stage Distribution

The dominant right eigenvector, normalized to sum to one, gives the stable stage distribution under fixed matrix conditions.

### Perturbation Screening

The R, Python, and C++ examples reduce adult survival by 10 percent to show how a single life-history parameter can influence long-run continuity.

### Life-History Continuity Scoring

The continuity score combines fecundity, juvenile survival, adult survival, maturation, dormancy or buffering, and environmental stress. It is not a universal index. It is a transparent scaffold for comparing assumptions.

## Interpretation

These workflows should be interpreted as educational life-cycle modeling scaffolds, not as operational biological forecasts. Real applications require species-specific vital rates, uncertainty analysis, sampling design, developmental context, ecological validation, and expert interpretation.
