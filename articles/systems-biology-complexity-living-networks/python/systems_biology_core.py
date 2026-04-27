"""
Core utilities for systems biology and complexity in living networks.
"""

from __future__ import annotations

from pathlib import Path
import hashlib
import math

import pandas as pd


def network_degree(nodes: pd.DataFrame, edges: pd.DataFrame) -> pd.DataFrame:
    """Calculate undirected degree from source and target interaction endpoints."""
    endpoints = pd.concat(
        [
            edges.rename(columns={"source": "node_id"})[["node_id"]],
            edges.rename(columns={"target": "node_id"})[["node_id"]],
        ],
        ignore_index=True,
    )

    degree = endpoints.value_counts("node_id").reset_index(name="degree")
    result = nodes.merge(degree, on="node_id", how="left").fillna({"degree": 0})
    result["degree"] = result["degree"].astype(int)
    return result


def network_density(n_nodes: int, n_edges: int, directed: bool = True) -> float:
    """Calculate network density."""
    if n_nodes <= 1:
        return 0.0

    possible = n_nodes * (n_nodes - 1) if directed else n_nodes * (n_nodes - 1) / 2
    return n_edges / possible


def simulate_signal_propagation(edges: pd.DataFrame, input_node: str, alpha: float, steps: int) -> pd.DataFrame:
    """Simulate directed weighted signal propagation."""
    nodes = sorted(set(edges["source"]).union(edges["target"]))
    state = {node: 0.0 for node in nodes}
    state[input_node] = 1.0
    rows = []

    for step in range(steps + 1):
        rows.append({"step": step, **state})

        next_state = {node: 0.0 for node in nodes}
        next_state[input_node] = 1.0

        for _, edge in edges.iterrows():
            next_state[edge["target"]] += (
                alpha
                * state[edge["source"]]
                * float(edge["weight"])
                * float(edge["sign"])
            )

        state = {node: max(min(value, 1.0), -1.0) for node, value in next_state.items()}

    return pd.DataFrame(rows)


def simulate_negative_feedback(
    scenario: str,
    x0: float,
    y0: float,
    production_x: float,
    production_y: float,
    degradation_x: float,
    degradation_y: float,
    hill_n: float,
    dt: float,
    steps: int,
) -> pd.DataFrame:
    """Simulate a two-variable negative-feedback scaffold."""
    x = float(x0)
    y = float(y0)
    rows = []

    for step in range(steps + 1):
        rows.append({"scenario": scenario, "step": step, "time": step * dt, "x": x, "y": y})

        dx = production_x / (1.0 + y ** hill_n) - degradation_x * x
        dy = production_y * x - degradation_y * y

        x = max(x + dt * dx, 0.0)
        y = max(y + dt * dy, 0.0)

    return pd.DataFrame(rows)


def pathway_activity(expression: pd.DataFrame, gene_sets: pd.DataFrame) -> pd.DataFrame:
    """Calculate pathway activity as mean z-score across pathway genes."""
    return (
        gene_sets.merge(expression, on="gene", how="left")
        .groupby("pathway")
        .agg(
            pathway_activity=("z_score", "mean"),
            n_measured_genes=("z_score", "count"),
            n_pathway_genes=("gene", "count"),
        )
        .reset_index()
    )


def flux_balance_residuals(reactions: pd.DataFrame, stoichiometry: pd.DataFrame) -> pd.DataFrame:
    """Calculate mass-balance residuals from stoichiometry and chosen fluxes."""
    flux_lookup = dict(zip(reactions["reaction"], reactions["chosen_flux"]))
    rows = []

    for _, row in stoichiometry.iterrows():
        balance = 0.0
        for reaction in reactions["reaction"]:
            balance += float(row[reaction]) * float(flux_lookup[reaction])

        rows.append(
            {
                "metabolite": row["metabolite"],
                "mass_balance_residual": balance,
            }
        )

    return pd.DataFrame(rows)


def validation_metrics(observed: pd.Series, predicted: pd.Series) -> pd.DataFrame:
    """Calculate compact validation metrics."""
    errors = observed.astype(float) - predicted.astype(float)

    return pd.DataFrame(
        {
            "metric": ["MAE", "RMSE", "Bias"],
            "value": [
                errors.abs().mean(),
                math.sqrt((errors ** 2).mean()),
                errors.mean(),
            ],
        }
    )


def sha256_file(path: Path) -> str:
    """Calculate SHA-256 checksum for a file."""
    digest = hashlib.sha256()

    with path.open("rb") as handle:
        for block in iter(lambda: handle.read(65536), b""):
            digest.update(block)

    return digest.hexdigest()


def safe_sha256(path: Path) -> str:
    """Return a checksum or a not-available marker."""
    if path.exists() and path.is_file():
        return sha256_file(path)
    return "not_available"
