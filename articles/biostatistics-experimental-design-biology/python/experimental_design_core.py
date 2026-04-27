"""
Core utilities for biostatistics and experimental design.

Run:
    python python/experimental_design_core.py
"""

from __future__ import annotations

from dataclasses import dataclass
import math
from typing import Iterable

import numpy as np


@dataclass(frozen=True)
class TwoGroupSummary:
    control_mean: float
    treated_mean: float
    mean_difference: float
    pooled_sd: float
    effect_size_d: float
    standard_error_difference: float
    ci_lower: float
    ci_upper: float


def pooled_standard_deviation(control: Iterable[float], treated: Iterable[float]) -> float:
    """Calculate pooled standard deviation for two groups."""

    x0 = np.asarray(list(control), dtype=float)
    x1 = np.asarray(list(treated), dtype=float)

    if len(x0) < 2 or len(x1) < 2:
        raise ValueError("Each group requires at least two observations.")

    s0 = x0.std(ddof=1)
    s1 = x1.std(ddof=1)

    return float(math.sqrt(((len(x0) - 1) * s0**2 + (len(x1) - 1) * s1**2) / (len(x0) + len(x1) - 2)))


def two_group_summary(control: Iterable[float], treated: Iterable[float], z: float = 1.96) -> TwoGroupSummary:
    """Summarize a two-group biological comparison."""

    x0 = np.asarray(list(control), dtype=float)
    x1 = np.asarray(list(treated), dtype=float)

    sp = pooled_standard_deviation(x0, x1)

    mean0 = float(x0.mean())
    mean1 = float(x1.mean())
    difference = mean1 - mean0

    se_difference = float(math.sqrt(x0.var(ddof=1) / len(x0) + x1.var(ddof=1) / len(x1)))

    return TwoGroupSummary(
        control_mean=mean0,
        treated_mean=mean1,
        mean_difference=difference,
        pooled_sd=sp,
        effect_size_d=difference / sp if sp > 0 else math.nan,
        standard_error_difference=se_difference,
        ci_lower=difference - z * se_difference,
        ci_upper=difference + z * se_difference,
    )


def randomized_block_allocation(blocks: list[str], treatments: list[str], replicates_per_treatment: int, seed: int = 42) -> list[dict[str, str]]:
    """Generate randomized treatment allocation within each block."""

    rng = np.random.default_rng(seed)
    rows: list[dict[str, str]] = []

    for block in blocks:
        assignments = np.repeat(treatments, repeats=replicates_per_treatment)
        rng.shuffle(assignments)

        for idx, treatment in enumerate(assignments, start=1):
            rows.append(
                {
                    "block": block,
                    "experimental_unit": f"{block}_unit_{idx:02d}",
                    "treatment": str(treatment),
                }
            )

    return rows


def approximate_two_group_sample_size(effect_size_d: float, alpha: float = 0.05, power: float = 0.80) -> float:
    """Approximate sample size per group for balanced two-group design.

    Uses z=1.96 for alpha=0.05 and z=0.84 for 80% power.
    """

    if effect_size_d <= 0:
        raise ValueError("effect_size_d must be positive.")

    z_alpha = 1.96 if abs(alpha - 0.05) < 1e-9 else 1.96
    z_beta = 0.84 if abs(power - 0.80) < 1e-9 else 0.84

    return 2 * (z_alpha + z_beta) ** 2 / effect_size_d**2


def main() -> None:
    control = [10.2, 11.1, 9.8, 10.5, 10.9, 11.0, 9.9, 10.4]
    treated = [12.1, 11.7, 12.4, 11.9, 12.0, 12.6, 11.8, 12.3]

    print(two_group_summary(control, treated))
    print("approx_n_per_group=", round(approximate_two_group_sample_size(0.8), 3))


if __name__ == "__main__":
    main()
