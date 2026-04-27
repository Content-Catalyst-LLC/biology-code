"""
Simulate antimicrobial resistance under selection.

Run from article directory:
    python python/01_antimicrobial_resistance_selection.py
"""

from pathlib import Path
import pandas as pd

from evolutionary_medicine_core import simulate_resistance_scenario


ARTICLE_DIR = Path(__file__).resolve().parents[1]
INPUT_PATH = ARTICLE_DIR / "data" / "resistance_scenarios.csv"
TRAJECTORY_PATH = ARTICLE_DIR / "outputs" / "tables" / "resistance_selection_trajectory.csv"
SUMMARY_PATH = ARTICLE_DIR / "outputs" / "tables" / "resistance_selection_summary.csv"


def main() -> None:
    TRAJECTORY_PATH.parent.mkdir(parents=True, exist_ok=True)

    scenarios = pd.read_csv(INPUT_PATH)
    trajectories = [simulate_resistance_scenario(row) for _, row in scenarios.iterrows()]
    trajectory = pd.concat(trajectories, ignore_index=True)

    summary = (
        trajectory.sort_values(["scenario", "step"])
        .groupby("scenario")
        .tail(1)
        .rename(columns={"resistant_frequency": "final_resistant_frequency"})
        [["scenario", "step", "final_resistant_frequency"]]
        .reset_index(drop=True)
    )

    trajectory.to_csv(TRAJECTORY_PATH, index=False)
    summary.to_csv(SUMMARY_PATH, index=False)

    print(summary.round(5).to_string(index=False))
    print(f"Saved: {TRAJECTORY_PATH}")
    print(f"Saved: {SUMMARY_PATH}")


if __name__ == "__main__":
    main()
