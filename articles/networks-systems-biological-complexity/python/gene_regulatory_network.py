"""
Gene regulatory network scaffold.

Run:
    python python/gene_regulatory_network.py
"""

from pathlib import Path

import pandas as pd

from network_complexity_core import adjacency_matrix, degree_table


ARTICLE_DIR = Path(__file__).resolve().parents[1]
EDGE_PATH = ARTICLE_DIR / "data" / "biological_network_edges.csv"


def main() -> None:
    edges = pd.read_csv(EDGE_PATH)

    regulatory_edges = edges[edges["source"].str.startswith("gene_") & edges["target"].str.startswith("gene_")].copy()

    nodes, adjacency = adjacency_matrix(regulatory_edges)
    degree_df = degree_table(nodes, adjacency)

    interaction_summary = (
        regulatory_edges.groupby("interaction_type")
        .size()
        .reset_index(name="n_edges")
        .sort_values("n_edges", ascending=False)
    )

    print(interaction_summary.to_string(index=False))
    print(degree_df.sort_values("degree", ascending=False).round(5).to_string(index=False))


if __name__ == "__main__":
    main()
