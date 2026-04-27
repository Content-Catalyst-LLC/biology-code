"""
Validate project data alignment across biostatistics, ecology, and genomics.

Run:
    python python/validate_project_data.py
"""

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]


def main() -> None:
    biostat = pd.read_csv(ARTICLE_DIR / "data" / "biostat_measurements.csv")
    ecology = pd.read_csv(ARTICLE_DIR / "data" / "ecology_counts.csv")
    counts = pd.read_csv(ARTICLE_DIR / "data" / "genomics_counts.csv")
    metadata = pd.read_csv(ARTICLE_DIR / "data" / "genomics_metadata.csv")

    count_samples = set(counts.columns) - {"gene_id"}
    metadata_samples = set(metadata["sample_id"])

    checks = pd.DataFrame(
        {
            "check": [
                "biostat_sample_ids_unique",
                "ecology_counts_nonnegative",
                "genomics_metadata_matches_counts",
                "genomics_gene_ids_unique",
            ],
            "passed": [
                biostat["sample_id"].is_unique,
                (ecology["count"] >= 0).all(),
                metadata_samples == count_samples,
                counts["gene_id"].is_unique,
            ],
            "details": [
                "unique" if biostat["sample_id"].is_unique else "duplicates found",
                "nonnegative" if (ecology["count"] >= 0).all() else "negative counts found",
                "matched" if metadata_samples == count_samples else "mismatch",
                "unique" if counts["gene_id"].is_unique else "duplicates found",
            ],
        }
    )

    print(checks.to_string(index=False))


if __name__ == "__main__":
    main()
