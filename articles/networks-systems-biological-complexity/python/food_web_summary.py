"""
Ecological food-web scaffold.

Run:
    python python/food_web_summary.py
"""

from pathlib import Path

import pandas as pd

from network_complexity_core import adjacency_matrix, degree_table, network_summary


ARTICLE_DIR = Path(__file__).resolve().parents[1]
EDGE_PATH = ARTICLE_DIR / "data" / "food_web_edges.csv"


def main() -> None:
    edges = pd.read_csv(EDGE_PATH)
    nodes, adjacency = adjacency_matrix(edges)

    summary = network_summary(nodes, adjacency)
    degree_df = degree_table(nodes, adjacency)

    module_counts = (
        edges.groupby("module")
        .size()
        .reset_index(name="n_edges")
        .sort_values("n_edges", ascending=False)
    )

    print(pd.DataFrame([summary.__dict__]).round(5).to_string(index=False))
    print(module_counts.to_string(index=False))
    print(degree_df.sort_values("degree", ascending=False).round(5).to_string(index=False))


if __name__ == "__main__":
    main()
