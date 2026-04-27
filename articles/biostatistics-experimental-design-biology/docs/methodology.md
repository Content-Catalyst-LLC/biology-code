# Methodology Notes

## Purpose

The computational examples formalize biostatistics and experimental design through workflows for randomized allocation, blocking, effect-size estimation, power simulation, factorial design, bootstrap intervals, permutation testing, and mixed-effects data structures.

## Experimental Unit

The experimental unit is the smallest unit independently assigned to a treatment or condition.

## Two-Group Mean Difference

delta = mean(treated) - mean(control)

## Pooled Standard Deviation

s_p = sqrt(((n1 - 1)s1^2 + (n0 - 1)s0^2) / (n1 + n0 - 2))

## Standardized Mean Difference

d = delta / s_p

## Standard Error of Difference

SE_delta = sqrt(s1^2 / n1 + s0^2 / n0)

## Power Approximation

n ≈ 2(z_alpha + z_beta)^2 / d^2

for a balanced two-group comparison.

## Blocked Design

response = grand mean + treatment effect + block effect + error

## Factorial Design

response = grand mean + factor A + factor B + A:B interaction + error

## Mixed-Effects Scaffold

response = fixed treatment effect + random grouping effect + residual error

## Interpretation

These workflows are educational and methodological scaffolds. They do not replace domain-specific experimental planning, preregistration, ethical review, regulatory statistics, or expert biostatistical consultation.
