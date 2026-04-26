"""
Simple biological network analysis workflow.

Run:
    python python/network_analysis.py
"""

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
EDGE_PATH = ARTICLE_DIR / "data" / "network_edges.csv"


def main() -> None:
    edges = pd.read_csv(EDGE_PATH)
    nodes = sorted(set(edges["source"]).union(edges["target"]))

    rows = []

    for node in nodes:
        out_edges = edges[edges["source"] == node]
        in_edges = edges[edges["target"] == node]

        rows.append(
            {
                "node": node,
                "in_degree": len(in_edges),
                "out_degree": len(out_edges),
                "total_degree": len(in_edges) + len(out_edges),
                "incoming_weight": in_edges["weight"].sum(),
                "outgoing_weight": out_edges["weight"].sum(),
            }
        )

    degree_df = pd.DataFrame(rows).sort_values(["total_degree", "node"], ascending=[False, True])

    print(degree_df.round(4).to_string(index=False))


if __name__ == "__main__":
    main()
