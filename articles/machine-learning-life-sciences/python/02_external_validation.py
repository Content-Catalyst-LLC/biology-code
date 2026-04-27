"""
Run external validation on synthetic held-out life-science samples.

Run from the article directory:
    python python/02_external_validation.py
"""

from pathlib import Path
import subprocess
import sys

import joblib
import pandas as pd

from ml_life_sciences_core import calculate_classification_metrics


ARTICLE_DIR = Path(__file__).resolve().parents[1]
FEATURES = ["immune_score", "metabolic_score", "morphology_score", "stress_response_score"]
MODEL_PATH = ARTICLE_DIR / "outputs" / "models" / "biomarker_classifier.joblib"
EXTERNAL_PATH = ARTICLE_DIR / "data" / "external_validation_samples.csv"
METRICS_PATH = ARTICLE_DIR / "outputs" / "tables" / "external_validation_metrics.csv"
PREDICTIONS_PATH = ARTICLE_DIR / "outputs" / "tables" / "external_validation_predictions.csv"


def ensure_model() -> None:
    """Train the model if the model artifact is missing."""
    if not MODEL_PATH.exists():
        subprocess.run([sys.executable, str(ARTICLE_DIR / "python" / "01_train_biomarker_classifier.py")], check=True)


def main() -> None:
    METRICS_PATH.parent.mkdir(parents=True, exist_ok=True)
    ensure_model()

    model = joblib.load(MODEL_PATH)
    external = pd.read_csv(EXTERNAL_PATH)

    probability = model.predict_proba(external[FEATURES])[:, 1]
    metrics = calculate_classification_metrics(external["observed_condition"], probability)

    predictions = external[["sample_id", "observed_condition"]].copy()
    predictions["predicted_probability"] = probability
    predictions["predicted_label"] = (probability >= 0.5).astype(int)

    metrics.to_csv(METRICS_PATH, index=False)
    predictions.to_csv(PREDICTIONS_PATH, index=False)

    print(metrics.round(5).to_string(index=False))
    print(f"Saved metrics: {METRICS_PATH}")
    print(f"Saved predictions: {PREDICTIONS_PATH}")


if __name__ == "__main__":
    main()
