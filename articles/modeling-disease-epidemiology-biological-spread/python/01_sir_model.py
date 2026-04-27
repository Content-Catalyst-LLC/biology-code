"""
Run SIR simulations across scenarios.

Run from article directory:
    python python/01_sir_model.py
"""

from pathlib import Path

import pandas as pd

from epidemiology_core import simulate_sir, summarize_sir


ARTICLE_DIR = Path(__file__).resolve().parents[1]
INPUT_PATH = ARTICLE_DIR / "data" / "model_scenarios.csv"
OUTPUT_PATH = ARTICLE_DIR / "outputs" / "simulations" / "sir_outputs.csv"
SUMMARY_PATH = ARTICLE_DIR / "outputs" / "tables" / "sir_summary.csv"


def main() -> None:
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)
    SUMMARY_PATH.parent.mkdir(parents=True, exist_ok=True)

    scenarios = pd.read_csv(INPUT_PATH)
    outputs = []

    for _, row in scenarios.iterrows():
        outputs.append(
            simulate_sir(
                scenario=str(row["scenario"]),
                population=float(row["population"]),
                initial_susceptible=float(row["initial_susceptible"]),
                initial_infected=float(row["initial_infected"]),
                initial_recovered=float(row["initial_recovered"]),
                beta=float(row["beta"]),
                gamma=float(row["gamma"]),
                dt=float(row["dt"]),
                steps=int(row["steps"]),
            )
        )

    result = pd.concat(outputs, ignore_index=True)
    summary = summarize_sir(result)

    result.to_csv(OUTPUT_PATH, index=False)
    summary.to_csv(SUMMARY_PATH, index=False)

    print(summary.round(5).to_string(index=False))
    print(f"Saved: {OUTPUT_PATH}")
    print(f"Saved: {SUMMARY_PATH}")


if __name__ == "__main__":
    main()
