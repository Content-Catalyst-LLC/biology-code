"""
DNA and protein sequence-feature extraction.

Run:
    python python/sequence_features.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd

from biomolecule_core import gc_content, protein_sequence_features


ARTICLE_DIR = Path(__file__).resolve().parents[1]
SEQUENCE_PATH = ARTICLE_DIR / "data" / "sequences.csv"


def main() -> None:
    """Extract DNA GC content and protein composition features."""

    records = pd.read_csv(SEQUENCE_PATH)

    rows = []

    for _, record in records.iterrows():
        sequence_type = record["sequence_type"].lower()
        sequence = record["sequence"]

        if sequence_type == "dna":
            rows.append(
                {
                    "sequence_id": record["sequence_id"],
                    "sequence_type": "DNA",
                    "length": len(sequence),
                    "gc_content": gc_content(sequence),
                    "hydrophobic_fraction": None,
                    "charged_fraction": None,
                }
            )
        elif sequence_type == "protein":
            features = protein_sequence_features(sequence)
            rows.append(
                {
                    "sequence_id": record["sequence_id"],
                    "sequence_type": "protein",
                    "length": features["length"],
                    "gc_content": None,
                    "hydrophobic_fraction": features["hydrophobic_fraction"],
                    "charged_fraction": features["charged_fraction"],
                }
            )
        else:
            raise ValueError(f"Unsupported sequence type: {record['sequence_type']}")

    print(pd.DataFrame(rows).round(4).to_string(index=False))


if __name__ == "__main__":
    main()
