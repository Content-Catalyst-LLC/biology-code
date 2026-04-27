"""
Simulate simple somatic clonal expansion scenarios.

Run from article directory:
    python python/04_somatic_evolution.py
"""

from pathlib import Path
import pandas as pd

from evolutionary_medicine_core import simulate_somatic_evolution


ARTICLE_DIR = Path(__file__).resolve().parents[1]
INPUT_PATH = ARTICLE_DIR / "data" / "somatic_evolution_scenarios.csv"
TRAJECTORY_PATH = ARTICLE_DIR / "outputs" / "tables" / "somatic_evolution_trajectory.csv"
SUMMARY_PATH = ARTICLE_DIR / "outputs" / "tables" / "somatic_evolution_summary.csv"


def main() -> None:
    TRAJECTORY_PATH.parent.mkdir(parents=True, exist_ok=True)

    scenarios = pd.read_csv(INPUT_PATH)
    trajectories = [simulate_somatic_evolution(row) for _, row in scenarios.iterrows()]
    trajectory = pd.concat(trajectories, ignore_index=True)

    summary = (
        trajectory.sort_values(["clone_id", "time"])
        .groupby("clone_id")
        .tail(1)
        .rename(columns={"clone_size": "final_clone_size"})
        [["clone_id", "time", "final_clone_size", "selection_context"]]
        .reset_index(drop=True)
    )

    trajectory.to_csv(TRAJECTORY_PATH, index=False)
    summary.to_csv(SUMMARY_PATH, index=False)

    print(summary.round(2).to_string(index=False))
    print(f"Saved: {TRAJECTORY_PATH}")
    print(f"Saved: {SUMMARY_PATH}")


if __name__ == "__main__":
    main()
