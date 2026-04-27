"""
Core utilities for biology ethics workflows.

All examples are synthetic and educational.
"""

from __future__ import annotations

from pathlib import Path
import hashlib

import pandas as pd


def ethical_review_scores(projects: pd.DataFrame) -> pd.DataFrame:
    """Calculate a conceptual ethical-review score."""
    result = projects.copy()
    result["ethical_review_score"] = (
        result["expected_benefit"] * 0.25
        - result["expected_harm"] * 0.20
        - result["uncertainty"] * 0.15
        + result["consent_quality"] * 0.15
        + result["justice_score"] * 0.15
        + result["reversibility"] * 0.10
    )
    result["requires_deeper_review"] = (
        (result["expected_harm"] > 0.35)
        | (result["uncertainty"] > 0.45)
        | (result["justice_score"] < 0.55)
        | (result["reversibility"] < 0.40)
    )
    return result.sort_values("ethical_review_score", ascending=False)


def consent_completeness(consent: pd.DataFrame) -> pd.DataFrame:
    """Calculate consent completeness and flag weak consent conditions."""
    result = consent.copy()
    result["consent_completeness"] = result["elements_understood"] / result["elements_required"]
    result["review_flag"] = (
        (result["consent_completeness"] < 0.75)
        | (~result["plain_language_available"].astype(bool))
        | (~result["withdrawal_explained"].astype(bool))
    )
    return result.sort_values("consent_completeness")


def justice_adjusted_benefit(data: pd.DataFrame) -> pd.DataFrame:
    """Calculate justice-adjusted benefit."""
    result = data.copy()
    result["justice_adjusted_benefit"] = (
        result["expected_benefit"] * (1.0 - result["inequality_penalty"])
    )
    return result.sort_values("justice_adjusted_benefit", ascending=False)


def ecological_risk_scores(data: pd.DataFrame) -> pd.DataFrame:
    """Calculate ecological and reversibility-adjusted risk."""
    result = data.copy()
    result["ecological_risk"] = (
        result["exposure_probability"] * result["harm_magnitude"] * result["uncertainty"]
    )
    result["reversibility_adjusted_risk"] = result["ecological_risk"] * (1.0 - result["reversibility"])
    result["monitoring_gap"] = 1.0 - result["monitoring_capacity"]
    return result.sort_values("reversibility_adjusted_risk", ascending=False)


def governance_flags(data: pd.DataFrame) -> pd.DataFrame:
    """Summarize governance requirements."""
    result = data.copy()
    requirement_columns = [
        "requires_irb",
        "requires_animal_review",
        "requires_biosafety_review",
        "requires_community_consultation",
        "requires_data_governance",
        "requires_ecological_assessment",
    ]
    for column in requirement_columns:
        result[column] = result[column].astype(bool)
    result["n_governance_requirements"] = result[requirement_columns].sum(axis=1)
    return result.sort_values("n_governance_requirements", ascending=False)


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
