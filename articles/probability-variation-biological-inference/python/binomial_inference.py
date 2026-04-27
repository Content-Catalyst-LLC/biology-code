"""
Binomial biological inference workflow.

Run:
    python python/binomial_inference.py
"""

from pathlib import Path

import pandas as pd

from probability_core import binomial_summary


ARTICLE_DIR = Path(__file__).resolve().parents[1]
DATA_PATH = ARTICLE_DIR / "data" / "binomial_trials.csv"


def main() -> None:
    data = pd.read_csv(DATA_PATH)

    rows = []

    for _, row in data.iterrows():
        summary = binomial_summary(int(row["successes"]), int(row["trials"]))

        rows.append(
            {
                "experiment": row["experiment"],
                "context": row["context"],
                "successes": summary.successes,
                "trials": summary.trials,
                "estimate": summary.estimate,
                "standard_error": summary.standard_error,
                "ci_lower": summary.normal_ci_lower,
                "ci_upper": summary.normal_ci_upper,
            }
        )

    print(pd.DataFrame(rows).round(5).to_string(index=False))


if __name__ == "__main__":
    main()
