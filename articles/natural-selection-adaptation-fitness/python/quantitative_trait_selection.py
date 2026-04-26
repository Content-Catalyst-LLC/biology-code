"""
Quantitative trait selection and breeder's equation response.

Run:
    python python/quantitative_trait_selection.py
"""

from __future__ import annotations

import numpy as np
import pandas as pd


def main() -> None:
    """Estimate selection differential and predicted response."""

    rng = np.random.default_rng(7)

    n = 5000
    trait = rng.normal(loc=0.0, scale=1.0, size=n)

    fitness = np.exp(0.5 * trait - 0.15 * trait**2)
    fitness = fitness / np.mean(fitness)

    mean_before = trait.mean()
    selected_mean = np.average(trait, weights=fitness)
    selection_differential = selected_mean - mean_before

    heritability = 0.40
    response = heritability * selection_differential
    predicted_next_mean = mean_before + response

    summary = pd.DataFrame(
        {
            "mean_before": [mean_before],
            "selected_mean": [selected_mean],
            "selection_differential_S": [selection_differential],
            "heritability_h2": [heritability],
            "response_R": [response],
            "predicted_next_mean": [predicted_next_mean],
        }
    )

    print(summary.round(4).to_string(index=False))


if __name__ == "__main__":
    main()
