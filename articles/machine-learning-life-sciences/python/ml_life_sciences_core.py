"""
Core utilities for Machine Learning in the Life Sciences.

The functions in this module support compact, reproducible examples for
synthetic life-science machine-learning workflows.
"""

from __future__ import annotations

from pathlib import Path
import hashlib
import json
from typing import Dict

import numpy as np
import pandas as pd
from sklearn.metrics import (
    accuracy_score,
    brier_score_loss,
    confusion_matrix,
    f1_score,
    precision_score,
    recall_score,
    roc_auc_score,
)


def load_training_table(article_dir: Path) -> pd.DataFrame:
    """Load sample metadata and biomarker features into one modeling table."""
    samples = pd.read_csv(article_dir / "data" / "biological_samples.csv")
    features = pd.read_csv(article_dir / "data" / "biomarker_features.csv")

    table = samples.merge(features, on="sample_id", how="inner")
    table["label"] = (table["condition"] == "case").astype(int)
    return table


def calculate_classification_metrics(y_true, y_probability, threshold: float = 0.5) -> pd.DataFrame:
    """Calculate compact classification metrics for biological prediction."""
    y_pred = (np.asarray(y_probability) >= threshold).astype(int)
    y_true = np.asarray(y_true).astype(int)

    tn, fp, fn, tp = confusion_matrix(y_true, y_pred, labels=[0, 1]).ravel()

    metrics: Dict[str, float] = {
        "accuracy": accuracy_score(y_true, y_pred),
        "sensitivity": recall_score(y_true, y_pred, zero_division=0),
        "specificity": tn / (tn + fp) if (tn + fp) > 0 else 0.0,
        "precision": precision_score(y_true, y_pred, zero_division=0),
        "f1_score": f1_score(y_true, y_pred, zero_division=0),
        "brier_score": brier_score_loss(y_true, y_probability),
        "true_positive": tp,
        "true_negative": tn,
        "false_positive": fp,
        "false_negative": fn,
    }

    if len(set(y_true)) == 2:
        metrics["roc_auc"] = roc_auc_score(y_true, y_probability)
    else:
        metrics["roc_auc"] = float("nan")

    return pd.DataFrame({"metric": list(metrics.keys()), "value": list(metrics.values())})


def sha256_file(path: Path) -> str:
    """Calculate SHA-256 checksum for a file."""
    digest = hashlib.sha256()

    with path.open("rb") as handle:
        for block in iter(lambda: handle.read(65536), b""):
            digest.update(block)

    return digest.hexdigest()


def safe_sha256(path: Path) -> str:
    """Return a checksum if the file exists."""
    if path.exists() and path.is_file():
        return sha256_file(path)
    return "not_available"


def write_json(path: Path, payload: dict) -> None:
    """Write a deterministic JSON file."""
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(payload, indent=2, sort_keys=True))
