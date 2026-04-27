"""
Summarize FASTQ-style read quality.

Run from article directory:
    python python/05_fastq_quality_summary.py
"""

from pathlib import Path

from genomics_sequence_core import parse_fastq_text, summarize_fastq


ARTICLE_DIR = Path(__file__).resolve().parents[1]
FASTQ_PATH = ARTICLE_DIR / "data" / "reads.fastq"
OUTPUT_PATH = ARTICLE_DIR / "outputs" / "tables" / "fastq_quality_summary.csv"


def main() -> None:
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)

    records = parse_fastq_text(FASTQ_PATH.read_text())
    summary = summarize_fastq(records)

    summary.to_csv(OUTPUT_PATH, index=False)

    print(summary.round(5).to_string(index=False))
    print(f"Saved: {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
