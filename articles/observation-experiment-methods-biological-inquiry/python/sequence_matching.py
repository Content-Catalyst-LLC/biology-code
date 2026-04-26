"""
Sequence-matching workflow.

Run:
    python python/sequence_matching.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd

from biological_methods_core import hamming_distance


ARTICLE_DIR = Path(__file__).resolve().parents[1]
REF_PATH = ARTICLE_DIR / "data" / "reference_sequences.csv"
QUERY_PATH = ARTICLE_DIR / "data" / "query_sequences.csv"


def main() -> None:
    refs = pd.read_csv(REF_PATH)
    queries = pd.read_csv(QUERY_PATH)

    rows = []

    for _, query in queries.iterrows():
        for _, ref in refs.iterrows():
            distance = hamming_distance(query["sequence"], ref["sequence"])
            similarity = 1 - distance / len(query["sequence"])

            rows.append(
                {
                    "query_id": query["query_id"],
                    "candidate_strain": ref["strain"],
                    "hamming_distance": distance,
                    "similarity": similarity,
                }
            )

    matches = pd.DataFrame(rows).sort_values(
        ["query_id", "hamming_distance", "candidate_strain"],
        ascending=[True, True, True],
    )

    best_matches = matches.groupby("query_id").head(1)

    print(matches.round(4).to_string(index=False))
    print("\nBest matches:")
    print(best_matches.round(4).to_string(index=False))


if __name__ == "__main__":
    main()
