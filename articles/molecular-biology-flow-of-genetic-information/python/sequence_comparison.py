"""
Sequence comparison by Hamming distance and Jukes-Cantor correction.

Run:
    python python/sequence_comparison.py
"""

from __future__ import annotations

from itertools import combinations
from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
SEQUENCES_PATH = ARTICLE_DIR / "data" / "sequences.csv"


def pairwise_distance(seq1: str, seq2: str) -> tuple[int, float, float]:
    """Return mismatch count, p-distance, and Jukes-Cantor distance."""

    mismatches = sum(a != b for a, b in zip(seq1, seq2))
    length = len(seq1)
    p_distance = mismatches / length
    jukes_cantor = np.nan if p_distance >= 0.75 else -(3 / 4) * np.log(1 - (4 / 3) * p_distance)
    return mismatches, p_distance, jukes_cantor


def main() -> None:
    """Build pairwise distance table and matrix."""

    seq_df = pd.read_csv(SEQUENCES_PATH)
    seqs = dict(zip(seq_df["sample"], seq_df["sequence"]))

    rows = []

    for sample_1, sample_2 in combinations(seqs.keys(), 2):
        mismatches, p_distance, jukes_cantor = pairwise_distance(
            seqs[sample_1],
            seqs[sample_2],
        )

        rows.append(
            {
                "sample_1": sample_1,
                "sample_2": sample_2,
                "mismatches": mismatches,
                "p_distance": p_distance,
                "jukes_cantor": jukes_cantor,
            }
        )

    dist_df = pd.DataFrame(rows)

    samples = list(seqs.keys())
    matrix = pd.DataFrame(np.zeros((len(samples), len(samples))), index=samples, columns=samples)

    for _, row in dist_df.iterrows():
        matrix.loc[row["sample_1"], row["sample_2"]] = row["jukes_cantor"]
        matrix.loc[row["sample_2"], row["sample_1"]] = row["jukes_cantor"]

    print(dist_df.round(4).to_string(index=False))
    print(matrix.round(4).to_string())


if __name__ == "__main__":
    main()
