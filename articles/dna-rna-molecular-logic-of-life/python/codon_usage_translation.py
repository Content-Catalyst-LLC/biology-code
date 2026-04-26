"""
DNA translation scaffold, codon usage, and GC content.

Run:
    python python/codon_usage_translation.py
"""

from __future__ import annotations

from collections import Counter
from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
CODING_PATH = ARTICLE_DIR / "data" / "coding_sequence.txt"


CODON_TABLE = {
    "ATA": "I", "ATC": "I", "ATT": "I", "ATG": "M",
    "ACA": "T", "ACC": "T", "ACG": "T", "ACT": "T",
    "AAC": "N", "AAT": "N", "AAA": "K", "AAG": "K",
    "AGC": "S", "AGT": "S", "AGA": "R", "AGG": "R",
    "CTA": "L", "CTC": "L", "CTG": "L", "CTT": "L",
    "CCA": "P", "CCC": "P", "CCG": "P", "CCT": "P",
    "CAC": "H", "CAT": "H", "CAA": "Q", "CAG": "Q",
    "CGA": "R", "CGC": "R", "CGG": "R", "CGT": "R",
    "GTA": "V", "GTC": "V", "GTG": "V", "GTT": "V",
    "GCA": "A", "GCC": "A", "GCG": "A", "GCT": "A",
    "GAC": "D", "GAT": "D", "GAA": "E", "GAG": "E",
    "GGA": "G", "GGC": "G", "GGG": "G", "GGT": "G",
    "TCA": "S", "TCC": "S", "TCG": "S", "TCT": "S",
    "TTC": "F", "TTT": "F", "TTA": "L", "TTG": "L",
    "TAC": "Y", "TAT": "Y", "TAA": "*", "TAG": "*",
    "TGC": "C", "TGT": "C", "TGA": "*", "TGG": "W",
}


def main() -> None:
    """Summarize codon usage, translate coding sequence, and calculate GC fraction."""

    coding_seq = CODING_PATH.read_text().strip().upper()

    codons = [
        coding_seq[i:i + 3]
        for i in range(0, len(coding_seq) - 2, 3)
        if len(coding_seq[i:i + 3]) == 3
    ]

    protein = "".join(CODON_TABLE.get(codon, "X") for codon in codons)
    counts = Counter(codons)
    total = sum(counts.values())

    codon_df = pd.DataFrame(
        {
            "codon": list(counts.keys()),
            "count": list(counts.values()),
        }
    )
    codon_df["fraction"] = codon_df["count"] / total

    gc_fraction = sum(base in {"G", "C"} for base in coding_seq) / len(coding_seq)

    print("Protein:", protein)
    print("GC fraction:", round(gc_fraction, 4))
    print(codon_df.sort_values("count", ascending=False).round(4).to_string(index=False))


if __name__ == "__main__":
    main()
