"""
Validate biological sample metadata for a notebook workflow.

Run from article directory:
    python python/01_validate_sample_metadata.py
"""

from pathlib import Path

import pandas as pd

from notebook_reproducibility_core import validate_metadata


ARTICLE_DIR = Path(__file__).resolve().parents[1]
SAMPLES_PATH = ARTICLE_DIR / "data" / "biological_sample_metadata.csv"
OUTPUT_DIR = ARTICLE_DIR / "outputs" / "tables"
VALIDATION_PATH = OUTPUT_DIR / "metadata_validation.csv"
GROUP_SUMMARY_PATH = OUTPUT_DIR / "group_summary.csv"
MISSINGNESS_PATH = OUTPUT_DIR / "missingness_summary.csv"
LOADED_COUNT_PATH = OUTPUT_DIR / "loaded_sample_count.csv"

REQUIRED_COLUMNS = {
    "sample_id",
    "species",
    "tissue_or_environment",
    "treatment",
    "batch",
    "collection_site",
    "collection_date",
    "response_value",
}


def main() -> None:
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

    samples = pd.read_csv(SAMPLES_PATH)

    validation = validate_metadata(samples, REQUIRED_COLUMNS)
    group_summary = (
        samples.groupby(["species", "treatment", "batch"])
        .agg(
            n_samples=("sample_id", "count"),
            mean_response=("response_value", "mean"),
            sd_response=("response_value", "std"),
        )
        .reset_index()
    )
    missingness = samples.isna().sum().reset_index()
    missingness.columns = ["column_name", "n_missing"]

    loaded_count = pd.DataFrame(
        {
            "artifact": [SAMPLES_PATH.name],
            "n_rows": [len(samples)],
            "n_columns": [len(samples.columns)],
        }
    )

    validation.to_csv(VALIDATION_PATH, index=False)
    group_summary.to_csv(GROUP_SUMMARY_PATH, index=False)
    missingness.to_csv(MISSINGNESS_PATH, index=False)
    loaded_count.to_csv(LOADED_COUNT_PATH, index=False)

    print(validation.to_string(index=False))
    print(group_summary.round(5).to_string(index=False))
    print(f"Saved: {VALIDATION_PATH}")
    print(f"Saved: {GROUP_SUMMARY_PATH}")
    print(f"Saved: {MISSINGNESS_PATH}")


if __name__ == "__main__":
    main()
