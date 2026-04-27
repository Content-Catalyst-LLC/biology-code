"""
Core utilities for data, measurement, and reproducibility in life-science workflows.

Run:
    python python/reproducibility_core.py
"""

from __future__ import annotations

from dataclasses import dataclass
import hashlib
from pathlib import Path

import numpy as np
import pandas as pd


@dataclass(frozen=True)
class MeasurementQualitySummary:
    n_total: int
    n_missing: int
    n_pass: int
    n_review: int
    n_fail: int
    completeness_rate: float
    qc_pass_rate: float
    mean_value: float
    sd_value: float
    coefficient_of_variation: float


def sha256_text(content: str) -> str:
    """Return SHA-256 hash for a text string."""
    return hashlib.sha256(content.encode("utf-8")).hexdigest()


def sha256_file(path: Path) -> str:
    """Return SHA-256 hash for a file."""
    digest = hashlib.sha256()

    with path.open("rb") as handle:
        for block in iter(lambda: handle.read(65536), b""):
            digest.update(block)

    return digest.hexdigest()


def validate_required_columns(data: pd.DataFrame, dictionary: pd.DataFrame) -> pd.DataFrame:
    """Validate required columns using a data dictionary."""
    required = set(dictionary.loc[dictionary["required"].astype(str).str.lower() == "true", "column_name"])
    observed = set(data.columns)
    missing = sorted(required - observed)

    return pd.DataFrame(
        {
            "check": ["required_columns_present"],
            "passed": [len(missing) == 0],
            "details": [", ".join(missing) if missing else "all required columns present"],
        }
    )


def validate_qc_flags(data: pd.DataFrame, allowed_flags: set[str] | None = None) -> pd.DataFrame:
    """Validate QC flags against a controlled set."""
    if allowed_flags is None:
        allowed_flags = {"pass", "review", "fail"}

    observed = set(data["qc_flag"].dropna().astype(str))
    invalid = sorted(observed - allowed_flags)

    return pd.DataFrame(
        {
            "check": ["qc_flags_valid"],
            "passed": [len(invalid) == 0],
            "details": [", ".join(invalid) if invalid else "all qc flags valid"],
        }
    )


def measurement_quality_summary(data: pd.DataFrame, value_col: str = "measurement_value") -> MeasurementQualitySummary:
    """Summarize completeness, QC flags, and measurement variation."""
    values = pd.to_numeric(data[value_col], errors="coerce")
    pass_values = values[data["qc_flag"] == "pass"].dropna()

    mean_value = float(pass_values.mean()) if len(pass_values) else float("nan")
    sd_value = float(pass_values.std(ddof=1)) if len(pass_values) > 1 else float("nan")

    return MeasurementQualitySummary(
        n_total=int(len(data)),
        n_missing=int(values.isna().sum()),
        n_pass=int((data["qc_flag"] == "pass").sum()),
        n_review=int((data["qc_flag"] == "review").sum()),
        n_fail=int((data["qc_flag"] == "fail").sum()),
        completeness_rate=float(1 - values.isna().sum() / len(data)) if len(data) else float("nan"),
        qc_pass_rate=float((data["qc_flag"] == "pass").sum() / len(data)) if len(data) else float("nan"),
        mean_value=mean_value,
        sd_value=sd_value,
        coefficient_of_variation=float(sd_value / mean_value) if mean_value != 0 else float("nan"),
    )


def uncertainty_budget(components: pd.DataFrame, coverage_factor: float = 2.0) -> pd.DataFrame:
    """Compute combined and expanded uncertainty from standard uncertainty components."""
    standard_uncertainties = pd.to_numeric(components["standard_uncertainty"], errors="coerce")

    if (standard_uncertainties < 0).any():
        raise ValueError("standard uncertainty components must be non-negative.")

    combined_standard_uncertainty = float(np.sqrt(np.sum(standard_uncertainties**2)))
    expanded_uncertainty = coverage_factor * combined_standard_uncertainty

    return pd.DataFrame(
        {
            "combined_standard_uncertainty": [combined_standard_uncertainty],
            "coverage_factor": [coverage_factor],
            "expanded_uncertainty": [expanded_uncertainty],
        }
    )


def main() -> None:
    article_dir = Path(__file__).resolve().parents[1]
    data = pd.read_csv(article_dir / "data" / "measurements.csv")
    dictionary = pd.read_csv(article_dir / "data" / "data_dictionary.csv")
    components = pd.read_csv(article_dir / "data" / "uncertainty_components.csv")

    print(validate_required_columns(data, dictionary).to_string(index=False))
    print(validate_qc_flags(data).to_string(index=False))
    print(pd.DataFrame([measurement_quality_summary(data).__dict__]).round(5).to_string(index=False))
    print(uncertainty_budget(components).round(5).to_string(index=False))


if __name__ == "__main__":
    main()
