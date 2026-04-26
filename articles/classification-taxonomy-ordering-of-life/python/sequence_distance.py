"""
Sequence-distance workflow.

Run:
    python python/sequence_distance.py
"""

from __future__ import annotations

from itertools import product
from pathlib import Path

import pandas as pd

from taxonomy_core import jukes_cantor_distance, p_distance


ARTICLE_DIR = Path(__file__).resolve().parents[1]
SEQ_PATH = ARTICLE_DIR / "data" / "aligned_sequences.csv"


def main() -> None:
    seq_df = pd.read_csv(SEQ_PATH)
    seqs = dict(zip(seq_df["taxon"], seq_df["sequence"]))
    taxa = list(seqs.keys())

    p_mat = pd.DataFrame(index=taxa, columns=taxa, dtype=float)
    jc_mat = pd.DataFrame(index=taxa, columns=taxa, dtype=float)

    for t1, t2 in product(taxa, taxa):
        p = p_distance(seqs[t1], seqs[t2])
        p_mat.loc[t1, t2] = p
        jc_mat.loc[t1, t2] = jukes_cantor_distance(p)

    print("Raw p-distance matrix:")
    print(p_mat.round(4).to_string())

    print("\nJukes-Cantor distance matrix:")
    print(jc_mat.round(4).to_string())


if __name__ == "__main__":
    main()
