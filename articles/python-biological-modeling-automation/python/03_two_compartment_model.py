"""
Run two-compartment biological model scenarios.

Run from article directory:
    python python/03_two_compartment_model.py
"""

from pathlib import Path

import pandas as pd

from modeling_automation_core import simulate_two_compartment_model, summarize_compartment_outputs


ARTICLE_DIR = Path(__file__).resolve().parents[1]
PARAMETER_PATH = ARTICLE_DIR / "data" / "compartment_parameters.csv"
OUTPUT_PATH = ARTICLE_DIR / "outputs" / "simulations" / "two_compartment_outputs.csv"
SUMMARY_PATH = ARTICLE_DIR / "outputs" / "tables" / "two_compartment_summary.csv"


def main() -> None:
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)
    SUMMARY_PATH.parent.mkdir(parents=True, exist_ok=True)

    parameters = pd.read_csv(PARAMETER_PATH)
    outputs = []

    for _, row in parameters.iterrows():
        outputs.append(
            simulate_two_compartment_model(
                scenario=str(row["scenario"]),
                initial_a=float(row["initial_a"]),
                initial_b=float(row["initial_b"]),
                k_ab=float(row["k_ab"]),
                k_ba=float(row["k_ba"]),
                k_clear=float(row["k_clear"]),
                dt=float(row["dt"]),
                steps=int(row["steps"]),
            )
        )

    result = pd.concat(outputs, ignore_index=True)
    summary = summarize_compartment_outputs(result)

    result.to_csv(OUTPUT_PATH, index=False)
    summary.to_csv(SUMMARY_PATH, index=False)

    print(summary.round(5).to_string(index=False))
    print(f"Saved: {OUTPUT_PATH}")
    print(f"Saved: {SUMMARY_PATH}")


if __name__ == "__main__":
    main()
