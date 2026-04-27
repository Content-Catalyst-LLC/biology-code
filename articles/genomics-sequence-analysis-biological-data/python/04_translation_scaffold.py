"""
Translate simple detected ORFs.

Run from article directory:
    python python/04_translation_scaffold.py
"""

from pathlib import Path
import subprocess
import sys

import pandas as pd

from genomics_sequence_core import parse_fasta_file, translate_dna


ARTICLE_DIR = Path(__file__).resolve().parents[1]
FASTA_PATH = ARTICLE_DIR / "data" / "sequences.fasta"
ORF_PATH = ARTICLE_DIR / "outputs" / "tables" / "orf_summary.csv"
OUTPUT_PATH = ARTICLE_DIR / "outputs" / "tables" / "translation_summary.csv"


def ensure_orfs() -> None:
    if not ORF_PATH.exists():
        subprocess.run([sys.executable, str(ARTICLE_DIR / "python" / "03_orf_detection.py")], check=True)


def main() -> None:
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)
    ensure_orfs()

    records = parse_fasta_file(FASTA_PATH)
    orfs = pd.read_csv(ORF_PATH)
    rows = []

    for _, row in orfs.iterrows():
        sequence = records[row["sequence_id"]]
        coding_sequence = sequence[int(row["start"]) : int(row["end"])]
        protein = translate_dna(coding_sequence)

        rows.append(
            {
                "sequence_id": row["sequence_id"],
                "orf_id": row["orf_id"],
                "coding_length": len(coding_sequence),
                "protein_length": len(protein),
                "protein_sequence": protein,
            }
        )

    result = pd.DataFrame(rows)

    if len(result) == 0:
        result = pd.DataFrame(columns=["sequence_id", "orf_id", "coding_length", "protein_length", "protein_sequence"])

    result.to_csv(OUTPUT_PATH, index=False)

    print(result.to_string(index=False))
    print(f"Saved: {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
