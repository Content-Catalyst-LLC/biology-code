"""
Create a simple scenario-level sensitivity summary.

Run from article directory:
    python python/05_sensitivity_summary.py
"""

from pathlib import Path
import subprocess
import sys

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
SWEEP_PATH = ARTICLE_DIR / "outputs" / "tables" / "parameter_sweep_summary.csv"
OUTPUT_PATH = ARTICLE_DIR / "outputs" / "tables" / "sensitivity_summary.csv"


def ensure_sweep_output() -> None:
    if not SWEEP_PATH.exists():
        subprocess.run([sys.executable, str(ARTICLE_DIR / "python" / "04_parameter_sweep.py")], check=True)


def main() -> None:
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)
    ensure_sweep_output()

    sweep = pd.read_csv(SWEEP_PATH)
    rows = []

    for model_name, subset in sweep.groupby("model"):
        baseline_candidates = subset[subset["scenario"].str.contains("baseline", case=False, regex=False)]

        if len(baseline_candidates) == 0:
            baseline_value = subset["primary_output"].mean()
            baseline_scenario = "mean_output"
        else:
            baseline_value = baseline_candidates.iloc[0]["primary_output"]
            baseline_scenario = baseline_candidates.iloc[0]["scenario"]

        for _, row in subset.iterrows():
            difference = row["primary_output"] - baseline_value
            relative_difference = difference / baseline_value if baseline_value != 0 else float("nan")

            rows.append(
                {
                    "model": model_name,
                    "baseline_scenario": baseline_scenario,
                    "scenario": row["scenario"],
                    "primary_output": row["primary_output"],
                    "difference_from_baseline": difference,
                    "relative_difference_from_baseline": relative_difference,
                }
            )

    result = pd.DataFrame(rows)
    result.to_csv(OUTPUT_PATH, index=False)

    print(result.round(5).to_string(index=False))
    print(f"Saved: {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
