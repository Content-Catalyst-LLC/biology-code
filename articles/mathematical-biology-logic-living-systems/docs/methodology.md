# Methodology Notes

## Purpose

The computational examples formalize several foundational concepts in mathematical biology: growth, constraint, feedback, interaction, infection, enzyme saturation, spatial diffusion, stochasticity, network structure, and parameter sensitivity.

## Exponential Growth

dN/dt = rN

N(t) = N0 exp(rt)

## Logistic Growth

dN/dt = rN(1 - N/K)

## Lotka-Volterra Predator-Prey Model

dX/dt = alpha X - beta X Y

dY/dt = delta X Y - gamma Y

## SIR Model

dS/dt = -beta S I

dI/dt = beta S I - gamma I

dR/dt = gamma I

## Michaelis-Menten Kinetics

v = Vmax S / (Km + S)

## Reaction-Diffusion Scaffold

du/dt = D_u Laplacian(u) + f(u, v)

dv/dt = D_v Laplacian(v) + g(u, v)

## Stochastic Birth-Death Process

Events occur with rates:

birth: lambda N

death: mu N

## Sensitivity

A simple normalized local sensitivity can be approximated as:

S_theta = (theta / y) * (dy / dtheta)

## Interpretation

These workflows are educational and methodological scaffolds. They do not replace domain-specific empirical calibration, validated numerical solvers, advanced uncertainty quantification, or expert biological interpretation.
