"""
Build adjacency matrix from biological network edge list.

Run:
    python python/adjacency_matrix.py
"""

from pathlib import Path

import pandas as pd

from network_complexity_core import adjacency_matrix


ARTICLE_DIR = Path(__file__).resolve().parents[1]
EDGE_PATH = ARTICLE_DIR / "data" / "biological_network_edges.csv"


def main() -> None:
    edges = pd.read_csv(EDGE_PATH)
    nodes, adjacency = adjacency_matrix(edges)

    adjacency_df = pd.DataFrame(adjacency, index=nodes, columns=nodes)

    print(adjacency_df.round(3).to_string())


if __name__ == "__main__":
    main()
