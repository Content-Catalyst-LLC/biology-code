"""
Summarize biological network topology.

Run from article directory:
    python python/01_network_summary.py
"""

from pathlib import Path

import pandas as pd

from systems_biology_core import network_degree, network_density


ARTICLE_DIR = Path(__file__).resolve().parents[1]
NODES_PATH = ARTICLE_DIR / "data" / "nodes.csv"
EDGES_PATH = ARTICLE_DIR / "data" / "interactions.csv"
OUTPUT_PATH = ARTICLE_DIR / "outputs" / "tables" / "network_summary.csv"
GRAPH_STATS_PATH = ARTICLE_DIR / "outputs" / "tables" / "network_graph_stats.csv"


def main() -> None:
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)

    nodes = pd.read_csv(NODES_PATH)
    edges = pd.read_csv(EDGES_PATH)

    summary = network_degree(nodes, edges)
    stats = pd.DataFrame(
        {
            "metric": ["n_nodes", "n_edges", "directed_density", "mean_degree"],
            "value": [
                len(nodes),
                len(edges),
                network_density(len(nodes), len(edges), directed=True),
                summary["degree"].mean(),
            ],
        }
    )

    summary.to_csv(OUTPUT_PATH, index=False)
    stats.to_csv(GRAPH_STATS_PATH, index=False)

    print(summary.sort_values("degree", ascending=False).to_string(index=False))
    print(stats.round(5).to_string(index=False))
    print(f"Saved: {OUTPUT_PATH}")
    print(f"Saved: {GRAPH_STATS_PATH}")


if __name__ == "__main__":
    main()
