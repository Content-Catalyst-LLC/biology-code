"""
Score synthetic biotechnology interventions.

Run from article directory:
    python python/01_intervention_risk_benefit.py
"""

from pathlib import Path
import pandas as pd

from biotechnology_intervention_core import score_interventions


ARTICLE_DIR = Path(__file__).resolve().parents[1]
INPUT_PATH = ARTICLE_DIR / "data" / "biotechnology_interventions.csv"
OUTPUT_PATH = ARTICLE_DIR / "outputs" / "tables" / "intervention_risk_benefit_scores.csv"


def main() -> None:
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)

    interventions = pd.read_csv(INPUT_PATH)
    scored = score_interventions(interventions)

    scored.to_csv(OUTPUT_PATH, index=False)

    print(scored.round(4).to_string(index=False))
    print(f"Saved: {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
