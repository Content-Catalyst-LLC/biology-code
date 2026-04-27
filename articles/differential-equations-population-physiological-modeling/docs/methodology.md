# Methodology Notes

## Purpose

The computational examples formalize differential-equation modeling in population biology and physiology through transparent numerical workflows.

## Euler Integration

For dX/dt = f(X, t), Euler integration updates:

X_next = X_current + f(X_current, t) * dt

Euler is transparent but not ideal for production modeling. Research applications should use validated ODE/PDE solvers.

## Exponential Growth

dN/dt = rN

## Logistic Growth

dN/dt = rN(1 - N/K)

## Predator-Prey System

dX/dt = alpha X - beta X Y

dY/dt = delta X Y - gamma Y

## SIR Model

dS/dt = -beta S I

dI/dt = beta S I - gamma I

dR/dt = gamma I

## Homeostatic Return

dx/dt = -k(x - set_point)

## Pharmacokinetic Elimination

dC/dt = -kC

## Chemostat

dX/dt = mu(S)X - DX

dS/dt = D(S_in - S) - (1/Y)mu(S)X

## Interpretation

These workflows are educational and methodological scaffolds. They do not replace domain-specific model calibration, validated numerical solvers, uncertainty analysis, or expert biological interpretation.
