"""
Validate sequence metadata against FASTA identifiers.

Run from article directory:
    python python/07_metadata_validation.py
"""

from pathlib import Path

import pandas as pd

from genomics_sequence_core import parse_fasta_file, validate_metadata


ARTICLE_DIR = Path(__file__).resolve().parents[1]
FASTA_PATH = ARTICLE_DIR / "data" / "sequences.fasta"
METADATA_PATH = ARTICLE_DIR / "data" / "sequence_metadata.csv"
OUTPUT_PATH = ARTICLE_DIR / "outputs" / "tables" / "metadata_validation.csv"


def main() -> None:
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)

    records = parse_fasta_file(FASTA_PATH)
    metadata = pd.read_csv(METADATA_PATH)

    report = validate_metadata(metadata, set(records.keys()))
    report.to_csv(OUTPUT_PATH, index=False)

    print(report.to_string(index=False))
    print(f"Saved: {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
