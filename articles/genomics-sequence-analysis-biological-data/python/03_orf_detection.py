"""
Detect simple forward-strand ORFs.

Run from article directory:
    python python/03_orf_detection.py
"""

from pathlib import Path

import pandas as pd

from genomics_sequence_core import find_simple_orfs, parse_fasta_file


ARTICLE_DIR = Path(__file__).resolve().parents[1]
FASTA_PATH = ARTICLE_DIR / "data" / "sequences.fasta"
OUTPUT_PATH = ARTICLE_DIR / "outputs" / "tables" / "orf_summary.csv"


def main() -> None:
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)

    records = parse_fasta_file(FASTA_PATH)
    rows = []

    for sequence_id, sequence in records.items():
        orfs = find_simple_orfs(sequence, minimum_codons=3)

        for orf_index, orf in enumerate(orfs, start=1):
            rows.append(
                {
                    "sequence_id": sequence_id,
                    "orf_id": f"{sequence_id}_orf_{orf_index}",
                    **orf,
                }
            )

    result = pd.DataFrame(rows)

    if len(result) == 0:
        result = pd.DataFrame(columns=["sequence_id", "orf_id", "frame", "start", "end", "codons", "stop_codon"])

    result.to_csv(OUTPUT_PATH, index=False)

    print(result.to_string(index=False))
    print(f"Saved: {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
