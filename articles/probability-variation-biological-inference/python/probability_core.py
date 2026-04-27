"""
Core probability utilities for biological inference.

Run:
    python python/probability_core.py
"""

from __future__ import annotations

import math
from dataclasses import dataclass
from typing import Iterable

import numpy as np


@dataclass(frozen=True)
class BinomialSummary:
    successes: int
    trials: int
    estimate: float
    standard_error: float
    normal_ci_lower: float
    normal_ci_upper: float


@dataclass(frozen=True)
class BetaPosterior:
    alpha_posterior: float
    beta_posterior: float
    posterior_mean: float
    posterior_variance: float


def validate_binomial(successes: int, trials: int) -> None:
    if trials < 0:
        raise ValueError("trials must be non-negative.")
    if successes < 0:
        raise ValueError("successes must be non-negative.")
    if successes > trials:
        raise ValueError("successes cannot exceed trials.")
    if trials == 0:
        raise ValueError("trials must be positive.")


def binomial_summary(successes: int, trials: int, z: float = 1.96) -> BinomialSummary:
    """Estimate a binomial probability and normal-approximation interval."""

    validate_binomial(successes, trials)

    estimate = successes / trials
    standard_error = math.sqrt(estimate * (1 - estimate) / trials)

    return BinomialSummary(
        successes=successes,
        trials=trials,
        estimate=estimate,
        standard_error=standard_error,
        normal_ci_lower=max(estimate - z * standard_error, 0.0),
        normal_ci_upper=min(estimate + z * standard_error, 1.0),
    )


def beta_binomial_update(alpha_prior: float, beta_prior: float, successes: int, trials: int) -> BetaPosterior:
    """Update a beta prior with binomial data."""

    if alpha_prior <= 0 or beta_prior <= 0:
        raise ValueError("Prior parameters must be positive.")

    validate_binomial(successes, trials)

    alpha_post = alpha_prior + successes
    beta_post = beta_prior + trials - successes
    total = alpha_post + beta_post

    return BetaPosterior(
        alpha_posterior=alpha_post,
        beta_posterior=beta_post,
        posterior_mean=alpha_post / total,
        posterior_variance=(alpha_post * beta_post) / (total**2 * (total + 1)),
    )


def bootstrap_mean(values: Iterable[float], n_bootstrap: int = 5000, seed: int = 42) -> dict[str, float]:
    """Bootstrap uncertainty for the mean."""

    arr = np.asarray(list(values), dtype=float)

    if len(arr) < 2:
        raise ValueError("At least two observations are required.")

    rng = np.random.default_rng(seed)
    boot = np.empty(n_bootstrap)

    for i in range(n_bootstrap):
        boot[i] = rng.choice(arr, size=len(arr), replace=True).mean()

    return {
        "observed_mean": float(arr.mean()),
        "bootstrap_mean": float(boot.mean()),
        "ci_lower": float(np.quantile(boot, 0.025)),
        "ci_upper": float(np.quantile(boot, 0.975)),
    }


def permutation_test_mean_difference(control: np.ndarray, treated: np.ndarray, n_permutations: int = 10000, seed: int = 42) -> dict[str, float]:
    """Two-sided permutation test for difference in means."""

    rng = np.random.default_rng(seed)

    observed_difference = float(treated.mean() - control.mean())
    combined = np.concatenate([control, treated])
    n_control = len(control)

    null_differences = np.empty(n_permutations)

    for i in range(n_permutations):
        shuffled = rng.permutation(combined)
        null_differences[i] = shuffled[n_control:].mean() - shuffled[:n_control].mean()

    p_value = float(np.mean(np.abs(null_differences) >= abs(observed_difference)))

    return {
        "observed_difference": observed_difference,
        "permutation_p_value": p_value,
        "null_mean": float(null_differences.mean()),
        "null_sd": float(null_differences.std(ddof=1)),
    }


def binomial_log_likelihood(successes: int, trials: int, p: float) -> float:
    """Calculate binomial log-likelihood up to the combinatorial constant."""

    validate_binomial(successes, trials)

    if p <= 0 or p >= 1:
        return float("-inf")

    failures = trials - successes

    return successes * math.log(p) + failures * math.log(1 - p)


def main() -> None:
    print(binomial_summary(68, 100))
    print(beta_binomial_update(1, 1, 68, 100))
    print("log_likelihood_p_0.68=", round(binomial_log_likelihood(68, 100, 0.68), 6))


if __name__ == "__main__":
    main()
