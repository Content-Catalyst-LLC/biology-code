"""
Borderline-case scoring workflow.

Run:
    python python/borderline_case_scoring.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd

from definition_core import heuristic_life_score


ARTICLE_DIR = Path(__file__).resolve().parents[1]
CASES_PATH = ARTICLE_DIR / "data" / "borderline_cases.csv"
WEIGHTS_PATH = ARTICLE_DIR / "data" / "life_criteria_weights.csv"


def category(score: float) -> str:
    """Classify heuristic score without claiming a universal definition."""

    if score >= 0.72:
        return "strongly_life_like_under_this_matrix"
    if score >= 0.45:
        return "borderline_or_context_dependent"
    return "weakly_life_like_under_this_matrix"


def main() -> None:
    """Score borderline cases using explicit weights."""

    cases = pd.read_csv(CASES_PATH)
    weights_df = pd.read_csv(WEIGHTS_PATH)
    weights = dict(zip(weights_df["criterion"], weights_df["weight"]))

    score_rows = []

    for _, row in cases.iterrows():
        criteria = {criterion: float(row[criterion]) for criterion in weights}
        score = heuristic_life_score(criteria, weights)

        score_rows.append(
            {
                "case": row["case"],
                "heuristic_life_score": score,
                "category": category(score),
                **criteria,
            }
        )

    result = pd.DataFrame(score_rows).sort_values("heuristic_life_score", ascending=False)

    print(result.round(3).to_string(index=False))


if __name__ == "__main__":
    main()
