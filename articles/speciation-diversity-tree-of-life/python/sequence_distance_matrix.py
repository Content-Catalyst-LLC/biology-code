"""
Pairwise sequence-distance matrix with Jukes-Cantor correction.

Run:
    python python/sequence_distance_matrix.py
"""

from __future__ import annotations

from itertools import combinations
from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
SEQUENCES_PATH = ARTICLE_DIR / "data" / "sequences.csv"


def pairwise_distance(seq1: str, seq2: str) -> tuple[int, float, float]:
    """Return mismatch count, p-distance, and Jukes-Cantor corrected distance."""

    mismatches = sum(a != b for a, b in zip(seq1, seq2))
    length = len(seq1)
    p_distance = mismatches / length
    jc = np.nan if p_distance >= 0.75 else -(3 / 4) * np.log(1 - (4 / 3) * p_distance)
    return mismatches, p_distance, jc


def main() -> None:
    """Build pairwise distance table and symmetric distance matrix."""

    sequence_df = pd.read_csv(SEQUENCES_PATH)
    seqs = dict(zip(sequence_df["taxon"], sequence_df["sequence"]))

    rows = []

    for taxon_1, taxon_2 in combinations(seqs.keys(), 2):
        mismatches, p_distance, jukes_cantor = pairwise_distance(
            seqs[taxon_1],
            seqs[taxon_2],
        )

        rows.append(
            {
                "taxon_1": taxon_1,
                "taxon_2": taxon_2,
                "mismatches": mismatches,
                "p_distance": p_distance,
                "jukes_cantor": jukes_cantor,
            }
        )

    dist_df = pd.DataFrame(rows)

    taxa = list(seqs.keys())
    matrix = pd.DataFrame(
        np.zeros((len(taxa), len(taxa))),
        index=taxa,
        columns=taxa,
    )

    for _, row in dist_df.iterrows():
        matrix.loc[row["taxon_1"], row["taxon_2"]] = row["jukes_cantor"]
        matrix.loc[row["taxon_2"], row["taxon_1"]] = row["jukes_cantor"]

    print(dist_df.round(4).to_string(index=False))
    print(matrix.round(4).to_string())


if __name__ == "__main__":
    main()
