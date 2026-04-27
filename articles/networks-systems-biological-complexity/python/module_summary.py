"""
Module-level network summary.

Run:
    python python/module_summary.py
"""

from pathlib import Path

import pandas as pd

from network_complexity_core import module_summary


ARTICLE_DIR = Path(__file__).resolve().parents[1]
EDGE_PATH = ARTICLE_DIR / "data" / "biological_network_edges.csv"
NODE_PATH = ARTICLE_DIR / "data" / "biological_network_nodes.csv"


def main() -> None:
    edges = pd.read_csv(EDGE_PATH)
    nodes = pd.read_csv(NODE_PATH)

    node_modules = dict(zip(nodes["node"], nodes["module"]))
    summary = module_summary(edges, node_modules)

    overall = pd.DataFrame(
        {
            "total_edges": [len(edges)],
            "within_module_edges": [
                sum(node_modules[s] == node_modules[t] for s, t in zip(edges["source"], edges["target"]))
            ],
        }
    )
    overall["between_module_edges"] = overall["total_edges"] - overall["within_module_edges"]
    overall["within_module_fraction"] = overall["within_module_edges"] / overall["total_edges"]

    print(overall.round(5).to_string(index=False))
    print(summary.round(5).to_string(index=False))


if __name__ == "__main__":
    main()
