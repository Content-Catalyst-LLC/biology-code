"""
Run deterministic logistic-growth model scenarios.

Run from article directory:
    python python/02_logistic_growth_model.py
"""

from pathlib import Path

import pandas as pd

from modeling_automation_core import simulate_logistic_growth, summarize_logistic_outputs


ARTICLE_DIR = Path(__file__).resolve().parents[1]
PARAMETER_PATH = ARTICLE_DIR / "data" / "logistic_parameters.csv"
OUTPUT_PATH = ARTICLE_DIR / "outputs" / "simulations" / "logistic_growth_outputs.csv"
SUMMARY_PATH = ARTICLE_DIR / "outputs" / "tables" / "logistic_growth_summary.csv"


def main() -> None:
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)
    SUMMARY_PATH.parent.mkdir(parents=True, exist_ok=True)

    parameters = pd.read_csv(PARAMETER_PATH)
    outputs = []

    for _, row in parameters.iterrows():
        outputs.append(
            simulate_logistic_growth(
                scenario=str(row["scenario"]),
                initial_population=float(row["initial_population"]),
                growth_rate=float(row["growth_rate"]),
                carrying_capacity=float(row["carrying_capacity"]),
                dt=float(row["dt"]),
                steps=int(row["steps"]),
            )
        )

    result = pd.concat(outputs, ignore_index=True)
    summary = summarize_logistic_outputs(result)

    result.to_csv(OUTPUT_PATH, index=False)
    summary.to_csv(SUMMARY_PATH, index=False)

    print(summary.round(5).to_string(index=False))
    print(f"Saved: {OUTPUT_PATH}")
    print(f"Saved: {SUMMARY_PATH}")


if __name__ == "__main__":
    main()
