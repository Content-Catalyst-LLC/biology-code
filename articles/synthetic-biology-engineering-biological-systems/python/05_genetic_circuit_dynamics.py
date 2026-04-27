"""
Simulate a simple genetic-circuit response.

Run from article directory:
    python python/05_genetic_circuit_dynamics.py
"""

from pathlib import Path
import pandas as pd

from synthetic_biology_core import simulate_circuit


ARTICLE_DIR = Path(__file__).resolve().parents[1]
INPUT_PATH = ARTICLE_DIR / "data" / "genetic_circuit_parameters.csv"
TRAJECTORY_PATH = ARTICLE_DIR / "outputs" / "tables" / "genetic_circuit_trajectory.csv"
SUMMARY_PATH = ARTICLE_DIR / "outputs" / "tables" / "genetic_circuit_summary.csv"


def main() -> None:
    TRAJECTORY_PATH.parent.mkdir(parents=True, exist_ok=True)

    parameters = pd.read_csv(INPUT_PATH)
    trajectory, summary = simulate_circuit(parameters)

    trajectory.to_csv(TRAJECTORY_PATH, index=False)
    summary.to_csv(SUMMARY_PATH, index=False)

    print(summary.round(4).to_string(index=False))
    print(f"Saved: {TRAJECTORY_PATH}")
    print(f"Saved: {SUMMARY_PATH}")


if __name__ == "__main__":
    main()
