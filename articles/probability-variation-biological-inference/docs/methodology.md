# Methodology Notes

## Purpose

The computational examples formalize probability, variation, and biological inference through reproducible workflows for binomial response, Bayesian updating, bootstrap uncertainty, permutation testing, power simulation, likelihood comparison, false-discovery scaffolds, and stochastic sampling.

## Binomial Model

K ~ Binomial(n, p)

P(K = k) = C(n, k) p^k (1 - p)^(n - k)

## Normal Approximation for Proportion

p_hat = k / n

SE = sqrt(p_hat (1 - p_hat) / n)

## Beta-Binomial Updating

p ~ Beta(alpha, beta)

k ~ Binomial(n, p)

p | k, n ~ Beta(alpha + k, beta + n - k)

## Bootstrap

Resample observed data with replacement and compute an estimator over repeated resamples.

## Permutation Test

Shuffle treatment labels under an exchangeability assumption and compare observed effect to the null distribution.

## Power Simulation

Simulate experiments under an assumed effect size and estimate the fraction that meet a significance or decision threshold.

## Likelihood

L(theta | data) is proportional to P(data | theta).

## Interpretation

These workflows are educational and methodological scaffolds. They do not replace domain-specific experimental design, validated statistical analysis, or expert biological interpretation.
