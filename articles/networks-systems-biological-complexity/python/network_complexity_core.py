"""
Core biological network and systems-complexity utilities.

Run:
    python python/network_complexity_core.py
"""

from __future__ import annotations

from dataclasses import dataclass

import numpy as np
import pandas as pd


@dataclass(frozen=True)
class NetworkSummary:
    n_nodes: int
    n_edges: int
    density: float
    mean_degree: float
    max_degree: float
    mean_weighted_degree: float


def build_node_list(edges: pd.DataFrame, source_col: str = "source", target_col: str = "target") -> list[str]:
    nodes = sorted(set(edges[source_col]).union(edges[target_col]))
    return nodes


def adjacency_matrix(
    edges: pd.DataFrame,
    nodes: list[str] | None = None,
    source_col: str = "source",
    target_col: str = "target",
    weight_col: str = "weight",
    directed: bool = False,
) -> tuple[list[str], np.ndarray]:
    if nodes is None:
        nodes = build_node_list(edges, source_col, target_col)

    index = {node: i for i, node in enumerate(nodes)}
    adjacency = np.zeros((len(nodes), len(nodes)), dtype=float)

    for _, row in edges.iterrows():
        source = row[source_col]
        target = row[target_col]
        weight = float(row[weight_col]) if weight_col in edges.columns else 1.0

        i = index[source]
        j = index[target]

        adjacency[i, j] += weight

        if not directed:
            adjacency[j, i] += weight

    return nodes, adjacency


def degree_table(nodes: list[str], adjacency: np.ndarray) -> pd.DataFrame:
    binary = adjacency > 0
    degree = binary.sum(axis=1)
    weighted_degree = adjacency.sum(axis=1)

    return pd.DataFrame(
        {
            "node": nodes,
            "degree": degree,
            "weighted_degree": weighted_degree,
            "degree_centrality": degree / max(len(nodes) - 1, 1),
        }
    )


def network_summary(nodes: list[str], adjacency: np.ndarray) -> NetworkSummary:
    n_nodes = len(nodes)
    binary = adjacency > 0

    n_edges = int(binary.sum() / 2)
    possible_edges = n_nodes * (n_nodes - 1) / 2
    density = n_edges / possible_edges if possible_edges > 0 else 0.0

    degrees = binary.sum(axis=1)
    weighted_degrees = adjacency.sum(axis=1)

    return NetworkSummary(
        n_nodes=n_nodes,
        n_edges=n_edges,
        density=float(density),
        mean_degree=float(degrees.mean()) if n_nodes > 0 else 0.0,
        max_degree=float(degrees.max()) if n_nodes > 0 else 0.0,
        mean_weighted_degree=float(weighted_degrees.mean()) if n_nodes > 0 else 0.0,
    )


def local_clustering(nodes: list[str], adjacency: np.ndarray) -> pd.DataFrame:
    binary = (adjacency > 0).astype(int)
    rows = []

    for i, node in enumerate(nodes):
        neighbors = np.where(binary[i] > 0)[0]
        k = len(neighbors)

        if k < 2:
            clustering = 0.0
        else:
            subgraph = binary[np.ix_(neighbors, neighbors)]
            neighbor_edges = subgraph.sum() / 2
            clustering = (2 * neighbor_edges) / (k * (k - 1))

        rows.append({"node": node, "clustering_coefficient": clustering})

    return pd.DataFrame(rows)


def module_summary(edges: pd.DataFrame, node_modules: dict[str, str]) -> pd.DataFrame:
    edge_df = edges.copy()
    edge_df["source_module"] = edge_df["source"].map(node_modules)
    edge_df["target_module"] = edge_df["target"].map(node_modules)
    edge_df["within_module"] = edge_df["source_module"] == edge_df["target_module"]

    return (
        edge_df.groupby(["source_module", "target_module"])
        .agg(
            n_edges=("source", "count"),
            mean_weight=("weight", "mean"),
            within_module_fraction=("within_module", "mean"),
        )
        .reset_index()
        .sort_values("n_edges", ascending=False)
    )


def diffuse_on_network(adjacency: np.ndarray, initial_state: np.ndarray, alpha: float, decay: float, steps: int) -> np.ndarray:
    if alpha < 0 or decay < 0:
        raise ValueError("alpha and decay must be non-negative.")
    if steps < 0:
        raise ValueError("steps must be non-negative.")

    state = initial_state.astype(float).copy()
    history = [state.copy()]

    for _ in range(steps):
        state = state + alpha * adjacency @ state - decay * state
        state = np.maximum(state, 0.0)
        history.append(state.copy())

    return np.vstack(history)


def remove_node_edge_retention(edges: pd.DataFrame, node: str) -> float:
    remaining = edges[(edges["source"] != node) & (edges["target"] != node)]
    return len(remaining) / len(edges) if len(edges) > 0 else 0.0


def main() -> None:
    edges = pd.DataFrame(
        {
            "source": ["A", "A", "B", "C", "D", "E"],
            "target": ["B", "C", "D", "D", "E", "F"],
            "weight": [1.0, 0.8, 0.7, 1.2, 0.9, 1.1],
        }
    )

    nodes, adjacency = adjacency_matrix(edges)
    print(network_summary(nodes, adjacency))
    print(degree_table(nodes, adjacency).sort_values("degree", ascending=False).to_string(index=False))
    print(local_clustering(nodes, adjacency).to_string(index=False))


if __name__ == "__main__":
    main()
