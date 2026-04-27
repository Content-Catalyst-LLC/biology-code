"""
Core utilities for computational ecology and environmental modeling.
"""

from __future__ import annotations

from pathlib import Path
import hashlib
import math

import pandas as pd


def logistic(value: float) -> float:
    """Stable logistic transformation for bounded suitability scores."""
    return 1.0 / (1.0 + math.exp(-value))


def habitat_suitability(row: pd.Series) -> float:
    """Estimate a synthetic habitat suitability score from environmental covariates."""
    linear_score = (
        -2.0
        + 0.05 * float(row["temperature_c"])
        + 0.0015 * float(row["precipitation_mm"])
        + 2.4 * float(row["habitat_quality"])
        - 2.0 * float(row["disturbance"])
    )
    return logistic(linear_score)


def simulate_patch_occupancy(
    scenario: str,
    initial_occupancy: float,
    colonization: float,
    extinction: float,
    steps: int,
) -> pd.DataFrame:
    """Simulate simple regional patch occupancy."""
    if not 0.0 <= initial_occupancy <= 1.0:
        raise ValueError("initial_occupancy must be between 0 and 1.")
    if not 0.0 <= colonization <= 1.0:
        raise ValueError("colonization must be between 0 and 1.")
    if not 0.0 <= extinction <= 1.0:
        raise ValueError("extinction must be between 0 and 1.")
    if steps < 1:
        raise ValueError("steps must be positive.")

    occupancy = float(initial_occupancy)
    rows = []

    for step in range(steps + 1):
        rows.append(
            {
                "scenario": scenario,
                "step": step,
                "occupancy": occupancy,
            }
        )

        occupancy = occupancy * (1.0 - extinction) + (1.0 - occupancy) * colonization
        occupancy = min(max(occupancy, 0.0), 1.0)

    return pd.DataFrame(rows)


def environmental_stress(row: pd.Series) -> float:
    """Calculate a synthetic environmental stress index."""
    return (
        0.40 * float(row["temperature_anomaly"])
        + 1.50 * float(row["water_deficit"])
        + 1.20 * float(row["disturbance"])
        - 1.00 * float(row["habitat_gain"])
    )


def relative_resilience(stress_index: float) -> float:
    """Convert stress to a bounded relative resilience proxy."""
    return 1.0 / (1.0 + stress_index)


def runoff_mm(row: pd.Series) -> float:
    """Calculate simplified runoff from precipitation, infiltration, and runoff coefficient."""
    precipitation = float(row["precipitation_mm"])
    infiltration = float(row["infiltration_fraction"])
    coefficient = float(row["runoff_coefficient"])

    return precipitation * (1.0 - infiltration) * coefficient


def validation_metrics(observed: pd.Series, predicted: pd.Series) -> pd.DataFrame:
    """Calculate compact validation metrics."""
    errors = observed.astype(float) - predicted.astype(float)

    rmse = math.sqrt((errors ** 2).mean())
    mae = errors.abs().mean()
    bias = errors.mean()

    return pd.DataFrame(
        {
            "metric": ["RMSE", "MAE", "Bias"],
            "value": [rmse, mae, bias],
        }
    )


def sha256_file(path: Path) -> str:
    """Calculate SHA-256 checksum for a file."""
    digest = hashlib.sha256()

    with path.open("rb") as handle:
        for block in iter(lambda: handle.read(65536), b""):
            digest.update(block)

    return digest.hexdigest()


def safe_sha256(path: Path) -> str:
    """Return a checksum or a not-available marker."""
    if path.exists() and path.is_file():
        return sha256_file(path)
    return "not_available"
