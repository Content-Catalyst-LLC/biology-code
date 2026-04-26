"""
Sequence-similarity workflow.

Run:
    python python/sequence_similarity.py
"""

from __future__ import annotations

from itertools import product
from pathlib import Path

import pandas as pd

from modern_biology_core import sequence_similarity


ARTICLE_DIR = Path(__file__).resolve().parents[1]
SEQ_PATH = ARTICLE_DIR / "data" / "sequences.csv"


def main() -> None:
    seq_df = pd.read_csv(SEQ_PATH)
    seqs = dict(zip(seq_df["sequence_id"], seq_df["sequence"]))

    rows = []

    for a, b in product(seqs.keys(), seqs.keys()):
        rows.append(
            {
                "sequence_a": a,
                "sequence_b": b,
                "similarity": sequence_similarity(seqs[a], seqs[b]),
            }
        )

    similarity_df = pd.DataFrame(rows)

    print(similarity_df.round(4).to_string(index=False))


if __name__ == "__main__":
    main()
