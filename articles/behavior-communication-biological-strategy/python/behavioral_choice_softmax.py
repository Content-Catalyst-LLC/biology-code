"""
Behavioral choice under risk with a softmax decision rule.

This script compares behavioral options under baseline and high-predation
conditions using a weighted utility function and softmax probabilities.

Run:
    python python/behavioral_choice_softmax.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
OPTIONS_PATH = ARTICLE_DIR / "data" / "behavioral_options.csv"


def softmax(values: pd.Series, beta: float = 1.0) -> np.ndarray:
    """Calculate numerically stable softmax probabilities."""

    centered = values.to_numpy(dtype=float) - values.max()
    exp_values = np.exp(beta * centered)
    return exp_values / exp_values.sum()


def calculate_choice_probabilities(
    options: pd.DataFrame,
    predation_weight: float,
    beta: float = 1.1,
) -> pd.DataFrame:
    """Calculate utility and softmax choice probabilities."""

    output = options.copy()

    output["utility"] = (
        output["benefit"]
        - 0.8 * output["energetic_cost"]
        - predation_weight * output["predation_risk"]
    )

    output["choice_probability"] = softmax(output["utility"], beta=beta)
    return output


def main() -> None:
    """Run behavioral choice scenarios."""

    options = pd.read_csv(OPTIONS_PATH)

    baseline = calculate_choice_probabilities(
        options=options,
        predation_weight=1.2,
    )
    baseline["scenario"] = "baseline"

    high_predation = calculate_choice_probabilities(
        options=options,
        predation_weight=1.8,
    )
    high_predation["scenario"] = "high_predation"

    combined = pd.concat([baseline, high_predation], ignore_index=True)

    print(
        combined[
            [
                "scenario",
                "option",
                "benefit",
                "energetic_cost",
                "predation_risk",
                "utility",
                "choice_probability",
            ]
        ]
        .round(3)
        .to_string(index=False)
    )


if __name__ == "__main__":
    main()
