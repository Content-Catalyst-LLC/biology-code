"""
Validate model parameters against expected bounds.

Run from article directory:
    python python/01_validate_parameters.py
"""

from pathlib import Path

import pandas as pd

from modeling_automation_core import validate_parameter_table


ARTICLE_DIR = Path(__file__).resolve().parents[1]
RULES_PATH = ARTICLE_DIR / "data" / "parameter_rules.csv"
LOGISTIC_PATH = ARTICLE_DIR / "data" / "logistic_parameters.csv"
COMPARTMENT_PATH = ARTICLE_DIR / "data" / "compartment_parameters.csv"
OUTPUT_PATH = ARTICLE_DIR / "outputs" / "tables" / "parameter_validation_report.csv"


def main() -> None:
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)

    rules = pd.read_csv(RULES_PATH)
    logistic = pd.read_csv(LOGISTIC_PATH)
    compartment = pd.read_csv(COMPARTMENT_PATH)

    report = pd.concat(
        [
            validate_parameter_table(logistic, rules, "logistic_parameters.csv"),
            validate_parameter_table(compartment, rules, "compartment_parameters.csv"),
        ],
        ignore_index=True,
    )

    report.to_csv(OUTPUT_PATH, index=False)

    failed = report[~report["passed"]]

    print(report.to_string(index=False))
    print(f"Saved: {OUTPUT_PATH}")

    if len(failed) > 0:
        raise SystemExit("Parameter validation failed. See report for details.")


if __name__ == "__main__":
    main()
