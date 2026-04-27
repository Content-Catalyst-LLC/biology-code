"""
Validate biological data tables.

Run:
    python python/validate_biological_data.py
"""

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]


def validate_measurements() -> pd.DataFrame:
    data = pd.read_csv(ARTICLE_DIR / "data" / "measurements.csv")

    required = {
        "sample_id",
        "treatment",
        "tissue",
        "batch_id",
        "instrument_id",
        "value",
        "unit",
        "qc_flag",
    }

    missing = sorted(required - set(data.columns))
    valid_flags = {"pass", "review", "fail"}
    invalid_flags = sorted(set(data["qc_flag"].dropna()) - valid_flags)

    return pd.DataFrame(
        {
            "check": ["required_columns", "valid_qc_flags", "unique_sample_ids"],
            "passed": [
                len(missing) == 0,
                len(invalid_flags) == 0,
                data["sample_id"].is_unique,
            ],
            "details": [
                "none" if not missing else ", ".join(missing),
                "none" if not invalid_flags else ", ".join(invalid_flags),
                "unique" if data["sample_id"].is_unique else "duplicates detected",
            ],
        }
    )


def validate_species_counts() -> pd.DataFrame:
    data = pd.read_csv(ARTICLE_DIR / "data" / "species_counts.csv")
    negative_counts = int((data["count"] < 0).sum())

    return pd.DataFrame(
        {
            "check": ["nonnegative_species_counts", "site_column_present"],
            "passed": [negative_counts == 0, "site" in data.columns],
            "details": [
                f"{negative_counts} negative counts",
                "present" if "site" in data.columns else "missing",
            ],
        }
    )


def main() -> None:
    result = pd.concat(
        [validate_measurements(), validate_species_counts()],
        ignore_index=True,
    )

    print(result.to_string(index=False))


if __name__ == "__main__":
    main()
