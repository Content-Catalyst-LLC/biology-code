"""
Run deterministic logistic-growth simulation scenarios.

Run from article directory:
    python python/01_logistic_growth_simulation.py
"""

from pathlib import Path

import pandas as pd

from biology_workflow_core import simulate_logistic_growth


ARTICLE_DIR = Path(__file__).resolve().parents[1]
PARAMETER_PATH = ARTICLE_DIR / "data" / "simulation_parameters.csv"
OUTPUT_PATH = ARTICLE_DIR / "outputs" / "simulations" / "logistic_growth_outputs.csv"


def main() -> None:
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)

    parameters = pd.read_csv(PARAMETER_PATH)
    deterministic = parameters[parameters["noise_sd"] == 0.0]

    outputs = []

    for _, row in deterministic.iterrows():
        outputs.append(
            simulate_logistic_growth(
                initial_population=float(row["initial_population"]),
                growth_rate=float(row["growth_rate"]),
                carrying_capacity=float(row["carrying_capacity"]),
                dt=float(row["dt"]),
                steps=int(row["steps"]),
                scenario=str(row["scenario"]),
            )
        )

    result = pd.concat(outputs, ignore_index=True)
    result.to_csv(OUTPUT_PATH, index=False)

    final_summary = result.groupby("scenario").tail(1)
    print(final_summary.round(5).to_string(index=False))
    print(f"Saved: {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
