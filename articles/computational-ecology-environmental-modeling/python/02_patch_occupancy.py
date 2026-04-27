"""
Simulate patch occupancy across scenarios.

Run from article directory:
    python python/02_patch_occupancy.py
"""

from pathlib import Path

import pandas as pd

from computational_ecology_core import simulate_patch_occupancy


ARTICLE_DIR = Path(__file__).resolve().parents[1]
INPUT_PATH = ARTICLE_DIR / "data" / "scenarios.csv"
OUTPUT_PATH = ARTICLE_DIR / "outputs" / "simulations" / "patch_occupancy.csv"
SUMMARY_PATH = ARTICLE_DIR / "outputs" / "tables" / "patch_occupancy_summary.csv"


def main() -> None:
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)
    SUMMARY_PATH.parent.mkdir(parents=True, exist_ok=True)

    scenarios = pd.read_csv(INPUT_PATH)
    outputs = []

    for _, row in scenarios.iterrows():
        outputs.append(
            simulate_patch_occupancy(
                scenario=str(row["scenario"]),
                initial_occupancy=float(row["initial_occupancy"]),
                colonization=float(row["colonization"]),
                extinction=float(row["extinction"]),
                steps=30,
            )
        )

    result = pd.concat(outputs, ignore_index=True)
    summary = result.sort_values(["scenario", "step"]).groupby("scenario").tail(1).reset_index(drop=True)
    summary = summary.rename(columns={"occupancy": "final_occupancy"})

    result.to_csv(OUTPUT_PATH, index=False)
    summary.to_csv(SUMMARY_PATH, index=False)

    print(summary.round(5).to_string(index=False))
    print(f"Saved: {OUTPUT_PATH}")
    print(f"Saved: {SUMMARY_PATH}")


if __name__ == "__main__":
    main()
