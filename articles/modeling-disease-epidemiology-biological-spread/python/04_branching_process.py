"""
Simulate stochastic branching-process outbreak scaffolds.

Run from article directory:
    python python/04_branching_process.py
"""

from pathlib import Path

import pandas as pd

from epidemiology_core import simulate_branching_process


ARTICLE_DIR = Path(__file__).resolve().parents[1]
INPUT_PATH = ARTICLE_DIR / "data" / "branching_parameters.csv"
OUTPUT_PATH = ARTICLE_DIR / "outputs" / "simulations" / "branching_process.csv"
SUMMARY_PATH = ARTICLE_DIR / "outputs" / "tables" / "branching_summary.csv"


def main() -> None:
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)
    SUMMARY_PATH.parent.mkdir(parents=True, exist_ok=True)

    parameters = pd.read_csv(INPUT_PATH)
    outputs = []

    for _, row in parameters.iterrows():
        outputs.append(
            simulate_branching_process(
                scenario=str(row["scenario"]),
                initial_cases=int(row["initial_cases"]),
                reproduction_mean=float(row["reproduction_mean"]),
                generations=int(row["generations"]),
                random_seed=int(row["random_seed"]),
            )
        )

    result = pd.concat(outputs, ignore_index=True)
    summary = (
        result.sort_values(["scenario", "generation"])
        .groupby("scenario")
        .tail(1)
        .rename(columns={"cases": "final_generation_cases"})
        .reset_index(drop=True)
    )

    result.to_csv(OUTPUT_PATH, index=False)
    summary.to_csv(SUMMARY_PATH, index=False)

    print(summary.to_string(index=False))
    print(f"Saved: {OUTPUT_PATH}")
    print(f"Saved: {SUMMARY_PATH}")


if __name__ == "__main__":
    main()
