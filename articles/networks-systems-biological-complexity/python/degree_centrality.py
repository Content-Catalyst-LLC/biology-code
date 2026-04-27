"""
Degree and centrality summaries.

Run:
    python python/degree_centrality.py
"""

from pathlib import Path

import pandas as pd

from network_complexity_core import adjacency_matrix, degree_table, local_clustering, network_summary


ARTICLE_DIR = Path(__file__).resolve().parents[1]
EDGE_PATH = ARTICLE_DIR / "data" / "biological_network_edges.csv"


def main() -> None:
    edges = pd.read_csv(EDGE_PATH)
    nodes, adjacency = adjacency_matrix(edges)

    summary = network_summary(nodes, adjacency)
    degree_df = degree_table(nodes, adjacency)
    clustering_df = local_clustering(nodes, adjacency)

    combined = degree_df.merge(clustering_df, on="node")

    print(pd.DataFrame([summary.__dict__]).round(5).to_string(index=False))
    print(combined.sort_values(["degree", "weighted_degree"], ascending=False).round(5).to_string(index=False))


if __name__ == "__main__":
    main()
