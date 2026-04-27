"""
Create a combined parameter-sweep summary across biological models.

Run from article directory:
    python python/04_parameter_sweep.py
"""

from pathlib import Path
import subprocess
import sys

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
LOGISTIC_SUMMARY = ARTICLE_DIR / "outputs" / "tables" / "logistic_growth_summary.csv"
COMPARTMENT_SUMMARY = ARTICLE_DIR / "outputs" / "tables" / "two_compartment_summary.csv"
OUTPUT_PATH = ARTICLE_DIR / "outputs" / "tables" / "parameter_sweep_summary.csv"


def ensure_required_outputs() -> None:
    if not LOGISTIC_SUMMARY.exists():
        subprocess.run([sys.executable, str(ARTICLE_DIR / "python" / "02_logistic_growth_model.py")], check=True)
    if not COMPARTMENT_SUMMARY.exists():
        subprocess.run([sys.executable, str(ARTICLE_DIR / "python" / "03_two_compartment_model.py")], check=True)


def main() -> None:
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)
    ensure_required_outputs()

    logistic = pd.read_csv(LOGISTIC_SUMMARY)
    compartment = pd.read_csv(COMPARTMENT_SUMMARY)

    logistic["primary_output"] = logistic["final_population"]
    compartment["primary_output"] = compartment["final_total_amount"]

    logistic_sweep = logistic[["model", "scenario", "time", "primary_output"]]
    compartment_sweep = compartment[["model", "scenario", "time", "primary_output"]]

    combined = pd.concat([logistic_sweep, compartment_sweep], ignore_index=True)
    combined.to_csv(OUTPUT_PATH, index=False)

    print(combined.round(5).to_string(index=False))
    print(f"Saved: {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
