"""
Train a leakage-aware synthetic biomarker classifier.

Run from the article directory:
    python python/01_train_biomarker_classifier.py
"""

from pathlib import Path

import joblib
import pandas as pd
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import train_test_split

from ml_life_sciences_core import calculate_classification_metrics, load_training_table, write_json


ARTICLE_DIR = Path(__file__).resolve().parents[1]
FEATURES = ["immune_score", "metabolic_score", "morphology_score", "stress_response_score"]
MODEL_PATH = ARTICLE_DIR / "outputs" / "models" / "biomarker_classifier.joblib"
METRICS_PATH = ARTICLE_DIR / "outputs" / "tables" / "training_validation_metrics.csv"
PREDICTIONS_PATH = ARTICLE_DIR / "outputs" / "tables" / "training_validation_predictions.csv"
MODEL_CARD_PATH = ARTICLE_DIR / "outputs" / "reports" / "biomarker_classifier_model_card.json"


def main() -> None:
    MODEL_PATH.parent.mkdir(parents=True, exist_ok=True)
    METRICS_PATH.parent.mkdir(parents=True, exist_ok=True)
    MODEL_CARD_PATH.parent.mkdir(parents=True, exist_ok=True)

    table = load_training_table(ARTICLE_DIR)

    X = table[FEATURES]
    y = table["label"]

    # In real biological studies, this split should reflect the unit of independence.
    # Examples include patient, organism, slide, site, sequencing run, or field plot.
    X_train, X_valid, y_train, y_valid, train_ids, valid_ids = train_test_split(
        X,
        y,
        table["sample_id"],
        test_size=0.33,
        random_state=42,
        stratify=y,
    )

    model = RandomForestClassifier(
        n_estimators=300,
        max_depth=3,
        random_state=42,
        class_weight="balanced",
    )

    model.fit(X_train, y_train)
    probability = model.predict_proba(X_valid)[:, 1]

    metrics = calculate_classification_metrics(y_valid, probability)
    predictions = pd.DataFrame(
        {
            "sample_id": list(valid_ids),
            "observed_label": list(y_valid),
            "predicted_probability": probability,
            "predicted_label": (probability >= 0.5).astype(int),
        }
    )

    joblib.dump(model, MODEL_PATH)
    metrics.to_csv(METRICS_PATH, index=False)
    predictions.to_csv(PREDICTIONS_PATH, index=False)

    write_json(
        MODEL_CARD_PATH,
        {
            "model_name": "synthetic_biomarker_random_forest",
            "article": "Machine Learning in the Life Sciences",
            "features": FEATURES,
            "label": "case/control condition encoded as 1/0",
            "random_seed": 42,
            "intended_use": "educational synthetic life-science machine-learning scaffold",
            "not_for_use": [
                "clinical diagnosis",
                "patient stratification",
                "regulatory decision-making",
                "biological mechanism claims",
            ],
            "validation_warning": "This is synthetic demonstration data only.",
        },
    )

    print(metrics.round(5).to_string(index=False))
    print(f"Saved model: {MODEL_PATH}")
    print(f"Saved metrics: {METRICS_PATH}")
    print(f"Saved predictions: {PREDICTIONS_PATH}")


if __name__ == "__main__":
    main()
