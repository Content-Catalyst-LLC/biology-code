"""
Run stochastic population-growth simulation scaffold.

Run from article directory:
    python python/02_stochastic_population_simulation.py
"""

from pathlib import Path

import pandas as pd

from biology_workflow_core import simulate_stochastic_growth


ARTICLE_DIR = Path(__file__).resolve().parents[1]
PARAMETER_PATH = ARTICLE_DIR / "data" / "simulation_parameters.csv"
OUTPUT_PATH = ARTICLE_DIR / "outputs" / "simulations" / "stochastic_population_outputs.csv"


def main() -> None:
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)

    parameters = pd.read_csv(PARAMETER_PATH)
    stochastic = parameters[parameters["noise_sd"] > 0.0]

    outputs = []

    for _, row in stochastic.iterrows():
        outputs.append(
            simulate_stochastic_growth(
                initial_population=float(row["initial_population"]),
                growth_rate=float(row["growth_rate"]),
                carrying_capacity=float(row["carrying_capacity"]),
                dt=float(row["dt"]),
                steps=int(row["steps"]),
                noise_sd=float(row["noise_sd"]),
                random_seed=int(row["random_seed"]),
                scenario=str(row["scenario"]),
            )
        )

    result = pd.concat(outputs, ignore_index=True)
    result.to_csv(OUTPUT_PATH, index=False)

    print(result.tail(10).round(5).to_string(index=False))
    print(f"Saved: {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
