"""
Simulate negative-feedback dynamics across scenarios.

Run from article directory:
    python python/03_feedback_dynamics.py
"""

from pathlib import Path

import pandas as pd

from systems_biology_core import simulate_negative_feedback


ARTICLE_DIR = Path(__file__).resolve().parents[1]
INPUT_PATH = ARTICLE_DIR / "data" / "feedback_parameters.csv"
OUTPUT_PATH = ARTICLE_DIR / "outputs" / "simulations" / "feedback_dynamics.csv"
SUMMARY_PATH = ARTICLE_DIR / "outputs" / "tables" / "feedback_summary.csv"


def main() -> None:
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)
    SUMMARY_PATH.parent.mkdir(parents=True, exist_ok=True)

    parameters = pd.read_csv(INPUT_PATH)
    outputs = []

    for _, row in parameters.iterrows():
        outputs.append(
            simulate_negative_feedback(
                scenario=str(row["scenario"]),
                x0=float(row["x0"]),
                y0=float(row["y0"]),
                production_x=float(row["production_x"]),
                production_y=float(row["production_y"]),
                degradation_x=float(row["degradation_x"]),
                degradation_y=float(row["degradation_y"]),
                hill_n=float(row["hill_n"]),
                dt=float(row["dt"]),
                steps=int(row["steps"]),
            )
        )

    result = pd.concat(outputs, ignore_index=True)
    summary = (
        result.sort_values(["scenario", "step"])
        .groupby("scenario")
        .tail(1)
        .rename(columns={"x": "final_x", "y": "final_y"})
        .reset_index(drop=True)
        [["scenario", "time", "final_x", "final_y"]]
    )

    result.to_csv(OUTPUT_PATH, index=False)
    summary.to_csv(SUMMARY_PATH, index=False)

    print(summary.round(5).to_string(index=False))
    print(f"Saved: {OUTPUT_PATH}")
    print(f"Saved: {SUMMARY_PATH}")


if __name__ == "__main__":
    main()
