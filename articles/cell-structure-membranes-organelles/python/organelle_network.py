"""
Organelle interaction network workflow.

Run:
    python python/organelle_network.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
NETWORK_PATH = ARTICLE_DIR / "data" / "organelle_network_edges.csv"


def main() -> None:
    """Calculate degree and weighted degree for organelle interaction network."""

    edges = pd.read_csv(NETWORK_PATH)
    nodes = sorted(set(edges["source"]).union(edges["target"]))

    centrality_rows = []

    for node in nodes:
        mask = (edges["source"] == node) | (edges["target"] == node)

        centrality_rows.append(
            {
                "organelle": node,
                "degree": int(mask.sum()),
                "weighted_degree": float(edges.loc[mask, "interaction_weight"].sum()),
                "mean_edge_weight": float(edges.loc[mask, "interaction_weight"].mean()),
            }
        )

    centrality = pd.DataFrame(centrality_rows).sort_values(
        "weighted_degree",
        ascending=False,
    )

    edge_type_summary = (
        edges.groupby("interaction_type")
        .agg(
            n_edges=("interaction_weight", "size"),
            mean_weight=("interaction_weight", "mean"),
        )
        .reset_index()
        .sort_values("mean_weight", ascending=False)
    )

    print(edges.round(3).to_string(index=False))
    print(centrality.round(3).to_string(index=False))
    print(edge_type_summary.round(3).to_string(index=False))


if __name__ == "__main__":
    main()
