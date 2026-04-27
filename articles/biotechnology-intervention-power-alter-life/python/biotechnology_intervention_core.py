"""
Core utilities for biotechnology intervention assessment.

All examples are synthetic and educational.
"""

from __future__ import annotations

from pathlib import Path
import hashlib
import math

import pandas as pd


def score_interventions(interventions: pd.DataFrame) -> pd.DataFrame:
    """Calculate a conceptual responsibility score for biotechnology interventions."""
    result = interventions.copy()
    result["responsibility_score"] = (
        result["expected_benefit"] * 0.30
        + result["access_equity"] * 0.20
        + result["reversibility"] * 0.20
        + result["governance_readiness"] * 0.15
        - result["expected_harm"] * 0.10
        - result["uncertainty"] * 0.05
    )
    return result.sort_values("responsibility_score", ascending=False)


def containment_failure_probability(layers: pd.DataFrame) -> float:
    """Estimate probability that at least one containment layer fails."""
    prob_no_failure = math.prod(1.0 - float(p) for p in layers["failure_probability"])
    return 1.0 - prob_no_failure


def equity_adjusted_access(access: pd.DataFrame) -> pd.DataFrame:
    """Calculate equity-adjusted access."""
    result = access.copy()
    result["equity_adjusted_access"] = (
        result["nominal_availability"] * (1.0 - result["inequality_penalty"])
    )
    return result.sort_values("equity_adjusted_access", ascending=False)


def ecological_risk_score(scenarios: pd.DataFrame) -> pd.DataFrame:
    """Calculate simplified ecological risk score."""
    result = scenarios.copy()
    result["risk_score"] = result["exposure"] * result["magnitude"] * result["uncertainty"]
    result["governance_buffer"] = result["monitoring_capacity"] * result["reversibility"]
    result["net_concern_score"] = result["risk_score"] * (1.0 - result["governance_buffer"])
    return result.sort_values("net_concern_score", ascending=False)


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
