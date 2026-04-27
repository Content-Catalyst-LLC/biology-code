"""
Count k-mers across FASTA sequence records.

Run from article directory:
    python python/04_kmer_counting.py
"""

from pathlib import Path

import pandas as pd

from biology_workflow_core import count_kmers, parse_fasta_file


ARTICLE_DIR = Path(__file__).resolve().parents[1]
FASTA_PATH = ARTICLE_DIR / "data" / "sequences.fasta"
OUTPUT_PATH = ARTICLE_DIR / "outputs" / "tables" / "kmer_counts.csv"


def main() -> None:
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)

    records = parse_fasta_file(FASTA_PATH)
    rows = []

    for sequence_id, sequence in records.items():
        counts = count_kmers(sequence, k=3)
        for kmer, count in sorted(counts.items()):
            rows.append(
                {
                    "sequence_id": sequence_id,
                    "k": 3,
                    "kmer": kmer,
                    "count": count,
                }
            )

    result = pd.DataFrame(rows)
    result.to_csv(OUTPUT_PATH, index=False)

    print(result.sort_values(["sequence_id", "count"], ascending=[True, False]).head(20).to_string(index=False))
    print(f"Saved: {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
