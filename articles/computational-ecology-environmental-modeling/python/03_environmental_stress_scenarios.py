"""
Compare environmental stress and resilience across scenarios.

Run from article directory:
    python python/03_environmental_stress_scenarios.py
"""

from pathlib import Path

import pandas as pd

from computational_ecology_core import environmental_stress, relative_resilience


ARTICLE_DIR = Path(__file__).resolve().parents[1]
INPUT_PATH = ARTICLE_DIR / "data" / "scenarios.csv"
OUTPUT_PATH = ARTICLE_DIR / "outputs" / "tables" / "environmental_stress.csv"


def main() -> None:
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)

    scenarios = pd.read_csv(INPUT_PATH)
    scenarios["stress_index"] = scenarios.apply(environmental_stress, axis=1)
    scenarios["relative_resilience"] = scenarios["stress_index"].apply(relative_resilience)

    scenarios.to_csv(OUTPUT_PATH, index=False)

    print(scenarios.round(5).to_string(index=False))
    print(f"Saved: {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
