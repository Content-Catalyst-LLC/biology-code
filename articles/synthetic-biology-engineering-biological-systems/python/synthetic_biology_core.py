"""
Core utilities for synthetic biology and engineering biology workflows.

All examples are synthetic and educational.
"""

from __future__ import annotations

from pathlib import Path
import hashlib

import pandas as pd


def score_designs(designs: pd.DataFrame) -> pd.DataFrame:
    """Calculate a conceptual engineering score for synthetic biology designs."""
    result = designs.copy()
    result["engineering_score"] = (
        result["output_signal"] * 0.40
        + result["genetic_stability"] * 0.30
        - result["host_burden"] * 0.20
        - result["measurement_uncertainty"] * 0.10
    )
    return result.sort_values("engineering_score", ascending=False)


def biosensor_signal_to_noise(measurements: pd.DataFrame) -> pd.DataFrame:
    """Calculate biosensor signal-to-noise ratio."""
    result = measurements.copy()
    result["signal_to_noise"] = (
        (result["mean_signal"] - result["mean_background"])
        / result["background_sd"]
    )
    return result.sort_values("signal_to_noise", ascending=False)


def host_burden_score(burden: pd.DataFrame) -> pd.DataFrame:
    """Calculate host burden from engineered and control growth rates."""
    result = burden.copy()
    result["burden_score"] = result.apply(
        lambda row: 0.0
        if row["growth_rate_control"] == 0
        else 1.0 - row["growth_rate_engineered"] / row["growth_rate_control"],
        axis=1,
    )
    return result.sort_values("burden_score")


def metabolic_yield(runs: pd.DataFrame) -> pd.DataFrame:
    """Calculate product yield from substrate and product amounts."""
    result = runs.copy()
    result["product_yield"] = result["product_formed_g_l"] / result["substrate_consumed_g_l"]
    return result.sort_values("product_yield", ascending=False)


def simulate_circuit(parameters: pd.DataFrame) -> tuple[pd.DataFrame, pd.DataFrame]:
    """Simulate a simple first-order genetic circuit response."""
    trajectories = []

    for _, row in parameters.iterrows():
        x = float(row["initial_x"])
        dt = float(row["dt"])
        for step in range(int(row["steps"]) + 1):
            trajectories.append(
                {
                    "scenario": row["scenario"],
                    "step": step,
                    "time": step * dt,
                    "x": x,
                }
            )
            dx = float(row["production_rate"]) * float(row["input_strength"]) - float(row["degradation_rate"]) * x
            x = max(x + dt * dx, 0.0)

    trajectory = pd.DataFrame(trajectories)
    summary = (
        trajectory.sort_values(["scenario", "step"])
        .groupby("scenario")
        .tail(1)
        .rename(columns={"x": "final_output"})
        [["scenario", "time", "final_output"]]
        .reset_index(drop=True)
    )

    return trajectory, summary


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
