"""
Summarize FASTA sequence records.

Run from article directory:
    python python/03_sequence_summary.py
"""

from pathlib import Path

from biology_workflow_core import parse_fasta_file, summarize_sequences


ARTICLE_DIR = Path(__file__).resolve().parents[1]
FASTA_PATH = ARTICLE_DIR / "data" / "sequences.fasta"
OUTPUT_PATH = ARTICLE_DIR / "outputs" / "tables" / "sequence_summary.csv"


def main() -> None:
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)

    records = parse_fasta_file(FASTA_PATH)
    summary = summarize_sequences(records)

    summary.to_csv(OUTPUT_PATH, index=False)

    print(summary.round(5).to_string(index=False))
    print(f"Saved: {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
