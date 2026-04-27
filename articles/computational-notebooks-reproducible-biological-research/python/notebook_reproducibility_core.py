"""
Core utilities for computational notebooks and reproducible biological research.
"""

from __future__ import annotations

from pathlib import Path
import hashlib

import pandas as pd


def sha256_file(path: Path) -> str:
    """Calculate a SHA-256 checksum for a file."""
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


def validate_metadata(samples: pd.DataFrame, required_columns: set[str]) -> pd.DataFrame:
    """Validate required columns, missingness, and unique sample identifiers."""
    rows = []

    missing_columns = sorted(required_columns.difference(samples.columns))
    rows.append(
        {
            "check_name": "required_columns_present",
            "status": "pass" if not missing_columns else "fail",
            "detail": "none" if not missing_columns else ";".join(missing_columns),
        }
    )

    if "sample_id" in samples.columns:
        rows.append(
            {
                "check_name": "sample_id_unique",
                "status": "pass" if samples["sample_id"].is_unique else "fail",
                "detail": f"n_samples={len(samples)};n_unique={samples['sample_id'].nunique()}",
            }
        )

    for column in sorted(required_columns.intersection(samples.columns)):
        n_missing = int(samples[column].isna().sum())
        rows.append(
            {
                "check_name": f"missingness_{column}",
                "status": "pass" if n_missing == 0 else "review",
                "detail": f"n_missing={n_missing}",
            }
        )

    return pd.DataFrame(rows)


def dataframe_to_markdown(df: pd.DataFrame) -> str:
    """Convert a small DataFrame to a markdown table without external dependencies."""
    headers = list(df.columns)
    lines = [
        "| " + " | ".join(headers) + " |",
        "| " + " | ".join(["---"] * len(headers)) + " |",
    ]

    for _, row in df.iterrows():
        lines.append("| " + " | ".join(str(row[col]) for col in headers) + " |")

    return "\n".join(lines)
