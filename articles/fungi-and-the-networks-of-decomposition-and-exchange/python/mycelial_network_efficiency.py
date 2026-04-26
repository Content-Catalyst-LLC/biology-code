"""
Mycelial network efficiency under connection loss.

This script computes global efficiency for a small weighted mycelial network
before and after structural damage.

Run:
    python python/mycelial_network_efficiency.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
EDGES_PATH = ARTICLE_DIR / "data" / "network_edges.csv"


def build_adjacency(edges: pd.DataFrame) -> tuple[list[str], np.ndarray]:
    """Build weighted adjacency matrix from edge table."""

    nodes = sorted(set(edges["source"]).union(set(edges["target"])))
    node_index = {node: index for index, node in enumerate(nodes)}
    adjacency = np.zeros((len(nodes), len(nodes)), dtype=float)

    for _, edge in edges.iterrows():
        i = node_index[edge["source"]]
        j = node_index[edge["target"]]
        weight = float(edge["weight"])
        adjacency[i, j] = weight
        adjacency[j, i] = weight

    return nodes, adjacency


def floyd_warshall(dist: np.ndarray) -> np.ndarray:
    """Compute all-pairs shortest paths."""

    dists = dist.copy()
    n_nodes = len(dists)

    for k in range(n_nodes):
        for i in range(n_nodes):
            for j in range(n_nodes):
                if dists[i, k] + dists[k, j] < dists[i, j]:
                    dists[i, j] = dists[i, k] + dists[k, j]

    return dists


def global_efficiency(adjacency: np.ndarray) -> float:
    """Compute global efficiency for a weighted network."""

    n_nodes = adjacency.shape[0]
    inf = 1e9

    dist = np.where(adjacency > 0, adjacency, inf).astype(float)
    np.fill_diagonal(dist, 0.0)

    shortest = floyd_warshall(dist)

    total = 0.0

    for i in range(n_nodes):
        for j in range(n_nodes):
            if i != j and shortest[i, j] < inf:
                total += 1.0 / shortest[i, j]

    return total / (n_nodes * (n_nodes - 1))


def main() -> None:
    """Compare baseline and damaged mycelial network efficiency."""

    edges = pd.read_csv(EDGES_PATH)
    nodes, adjacency = build_adjacency(edges)

    baseline = global_efficiency(adjacency)

    damaged = adjacency.copy()
    i = nodes.index("patch_3")
    j = nodes.index("patch_4")
    damaged[i, j] = 0.0
    damaged[j, i] = 0.0

    damaged_efficiency = global_efficiency(damaged)
    percent_decline = 100 * (baseline - damaged_efficiency) / baseline

    print(f"Baseline efficiency: {baseline:.4f}")
    print(f"Damaged efficiency: {damaged_efficiency:.4f}")
    print(f"Percent decline: {percent_decline:.2f}%")


if __name__ == "__main__":
    main()
