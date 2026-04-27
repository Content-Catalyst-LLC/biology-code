"""
Create a feature-importance report for model inspection.

Feature importance is not biological causality.
It should be used as an inspection tool only.

Run from the article directory:
    python python/03_feature_importance_report.py
"""

from pathlib import Path
import subprocess
import sys

import joblib
import pandas as pd

from ml_life_sciences_core import load_training_table


ARTICLE_DIR = Path(__file__).resolve().parents[1]
FEATURES = ["immune_score", "metabolic_score", "morphology_score", "stress_response_score"]
MODEL_PATH = ARTICLE_DIR / "outputs" / "models" / "biomarker_classifier.joblib"
OUTPUT_PATH = ARTICLE_DIR / "outputs" / "tables" / "feature_importance.csv"


def ensure_model() -> None:
    if not MODEL_PATH.exists():
        subprocess.run([sys.executable, str(ARTICLE_DIR / "python" / "01_train_biomarker_classifier.py")], check=True)


def main() -> None:
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)
    ensure_model()

    model = joblib.load(MODEL_PATH)
    table = load_training_table(ARTICLE_DIR)

    importance = pd.DataFrame(
        {
            "feature": FEATURES,
            "importance": model.feature_importances_,
            "interpretation_warning": "Feature importance is model inspection, not biological mechanism.",
        }
    ).sort_values("importance", ascending=False)

    importance["feature_mean"] = [table[feature].mean() for feature in importance["feature"]]
    importance["feature_sd"] = [table[feature].std() for feature in importance["feature"]]

    importance.to_csv(OUTPUT_PATH, index=False)

    print(importance.round(5).to_string(index=False))
    print(f"Saved: {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
