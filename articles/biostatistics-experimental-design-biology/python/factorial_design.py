"""
Factorial design workflow.

Run:
    python python/factorial_design.py
"""

import itertools
from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
DATA_PATH = ARTICLE_DIR / "data" / "factorial_design_observations.csv"


def build_factorial_design() -> pd.DataFrame:
    factor_a = ["ambient", "high_temperature"]
    factor_b = ["low", "high"]
    replicates = range(1, 5)

    rows = []

    for temperature, nutrient, replicate in itertools.product(factor_a, factor_b, replicates):
        rows.append(
            {
                "temperature": temperature,
                "nutrient": nutrient,
                "replicate": replicate,
                "experimental_unit": f"{temperature}_{nutrient}_rep_{replicate}",
            }
        )

    return pd.DataFrame(rows)


def main() -> None:
    design = build_factorial_design()
    observations = pd.read_csv(DATA_PATH)

    summary = (
        observations.groupby(["temperature", "nutrient"])
        .agg(
            n=("response", "count"),
            mean_response=("response", "mean"),
            sd_response=("response", "std"),
        )
        .reset_index()
    )

    print(design.to_string(index=False))
    print(summary.round(5).to_string(index=False))


if __name__ == "__main__":
    main()
