"""
Two-group inference workflow.

Run:
    python python/two_group_inference.py
"""

from pathlib import Path

import pandas as pd

from experimental_design_core import two_group_summary


ARTICLE_DIR = Path(__file__).resolve().parents[1]
DATA_PATH = ARTICLE_DIR / "data" / "two_group_measurements.csv"


def main() -> None:
    data = pd.read_csv(DATA_PATH)

    control = data.loc[data["group"] == "control", "value"].to_numpy()
    treated = data.loc[data["group"] == "treated", "value"].to_numpy()

    summary = two_group_summary(control, treated)

    result = pd.DataFrame([summary.__dict__])

    print(result.round(5).to_string(index=False))


if __name__ == "__main__":
    main()
