"""
Simple robustness simulation by node removal.

Run:
    python python/robustness_simulation.py
"""

from pathlib import Path

import pandas as pd

from network_complexity_core import build_node_list, remove_node_edge_retention


ARTICLE_DIR = Path(__file__).resolve().parents[1]
EDGE_PATH = ARTICLE_DIR / "data" / "biological_network_edges.csv"


def main() -> None:
    edges = pd.read_csv(EDGE_PATH)
    nodes = build_node_list(edges)

    rows = []

    for node in nodes:
        retention = remove_node_edge_retention(edges, node)
        rows.append(
            {
                "removed_node": node,
                "original_edges": len(edges),
                "remaining_edges": int(round(retention * len(edges))),
                "edge_retention": retention,
                "edge_loss": 1 - retention,
            }
        )

    result = pd.DataFrame(rows).sort_values(["edge_retention", "removed_node"])

    print(result.round(5).to_string(index=False))


if __name__ == "__main__":
    main()
