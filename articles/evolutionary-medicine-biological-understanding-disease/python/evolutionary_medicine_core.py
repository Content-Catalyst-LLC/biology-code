"""
Core utilities for evolutionary medicine workflows.

All examples are synthetic and educational.
"""

from __future__ import annotations

from pathlib import Path
import hashlib
import math

import pandas as pd


def simulate_resistance_scenario(row: pd.Series) -> pd.DataFrame:
    """Simulate bounded resistant-strain frequency for one scenario."""
    frequency = float(row["initial_frequency"])
    rows = []

    for step in range(int(row["steps"]) + 1):
        rows.append(
            {
                "scenario": row["scenario"],
                "step": step,
                "resistant_frequency": frequency,
            }
        )

        growth_factor = 1.0 + float(row["selection_advantage"]) - float(row["fitness_cost"])
        frequency = max(0.0, min(frequency * growth_factor, 1.0))

    return pd.DataFrame(rows)


def mismatch_scores(exposures: pd.DataFrame) -> pd.DataFrame:
    """Calculate conceptual mismatch scores."""
    result = exposures.copy()
    result["mismatch_distance"] = (
        result["current_exposure"] - result["adapted_exposure_reference"]
    ).abs()
    result["weighted_mismatch_score"] = result["mismatch_distance"] * result["evidence_confidence"]
    return result.sort_values("weighted_mismatch_score", ascending=False)


def life_history_tradeoffs(allocation: pd.DataFrame) -> pd.DataFrame:
    """Summarize life-history allocation trade-offs."""
    result = allocation.copy()
    result["total_allocation"] = (
        result["growth"] + result["reproduction"] + result["maintenance"] + result["immune_defense"]
    )
    result["maintenance_risk_index"] = 1.0 - result["maintenance"]
    result["inflammation_pressure_index"] = result["immune_defense"] * (1.0 - result["maintenance"])
    return result.sort_values("maintenance_risk_index", ascending=False)


def simulate_somatic_evolution(row: pd.Series) -> pd.DataFrame:
    """Simulate clonal expansion for one clone."""
    rows = []
    for time in range(int(row["time_steps"]) + 1):
        clone_size = float(row["initial_clone_size"]) * math.exp(float(row["growth_rate"]) * time)
        rows.append(
            {
                "clone_id": row["clone_id"],
                "time": time,
                "clone_size": clone_size,
                "selection_context": row["selection_context"],
            }
        )
    return pd.DataFrame(rows)


def defense_threshold_summary(defenses: pd.DataFrame) -> pd.DataFrame:
    """Evaluate conceptual defense activation thresholds."""
    result = defenses.copy()
    result["defense_activated"] = result["threat_level"] >= result["activation_threshold"]
    result["threshold_margin"] = result["threat_level"] - result["activation_threshold"]
    result["risk_balance_index"] = result.apply(
        lambda row: row["missed_threat_cost"] if not row["defense_activated"] else row["false_alarm_cost"],
        axis=1,
    )
    return result.sort_values("risk_balance_index", ascending=False)


def sha256_file(path: Path) -> str:
    """Calculate SHA-256 checksum for a file."""
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for block in iter(lambda: handle.read(65536), b""):
            digest.update(block)
    return digest.hexdigest()


def safe_sha256(path: Path) -> str:
    """Return a checksum or not-available marker."""
    if path.exists() and path.is_file():
        return sha256_file(path)
    return "not_available"


def dataframe_to_markdown(df: pd.DataFrame) -> str:
    """Convert a small DataFrame to markdown without external dependencies."""
    headers = list(df.columns)
    lines = [
        "| " + " | ".join(headers) + " |",
        "| " + " | ".join(["---"] * len(headers)) + " |",
    ]
    for _, row in df.iterrows():
        lines.append("| " + " | ".join(str(row[col]) for col in headers) + " |")
    return "\n".join(lines)
