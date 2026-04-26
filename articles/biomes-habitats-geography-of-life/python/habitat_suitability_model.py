"""
Habitat suitability modeling for biomes and the geography of life.

This script fits a compact logistic-regression habitat suitability model
using environmental predictors. It is intentionally small for transparency.

Run:
    python python/habitat_suitability_model.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd
from sklearn.linear_model import LogisticRegression
from sklearn.model_selection import cross_val_score
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import StandardScaler


ARTICLE_DIR = Path(__file__).resolve().parents[1]
DATA_PATH = ARTICLE_DIR / "data" / "habitat_sites.csv"


def main() -> None:
    """Fit a compact habitat-suitability model and rank sites."""

    sites = pd.read_csv(DATA_PATH)

    predictors = [
        "temperature",
        "precipitation",
        "soil_quality",
        "connectivity",
        "disturbance",
        "land_use_pressure",
    ]

    X = sites[predictors]
    y = sites["occurrence"]

    model = Pipeline(
        [
            ("scaler", StandardScaler()),
            ("clf", LogisticRegression(max_iter=1000)),
        ]
    )

    # For a real spatial workflow, use spatially blocked cross-validation.
    cv_scores = cross_val_score(model, X, y, cv=4, scoring="roc_auc")

    model.fit(X, y)

    sites["suitability_probability"] = model.predict_proba(X)[:, 1]
    sites["priority_score"] = (
        0.45 * sites["suitability_probability"]
        + 0.30 * sites["connectivity"]
        - 0.25 * sites["land_use_pressure"]
    )

    ranked = sites.sort_values("priority_score", ascending=False).reset_index(drop=True)

    print("Mean CV AUC:", round(float(np.mean(cv_scores)), 3))
    print(
        ranked[
            [
                "site_id",
                "suitability_probability",
                "connectivity",
                "land_use_pressure",
                "priority_score",
            ]
        ]
        .round(3)
        .to_string(index=False)
    )


if __name__ == "__main__":
    main()
