"""
Diffusion or perturbation spread on a biological network.

Run:
    python python/network_diffusion.py
"""

from pathlib import Path

import numpy as np
import pandas as pd

from network_complexity_core import adjacency_matrix, diffuse_on_network


ARTICLE_DIR = Path(__file__).resolve().parents[1]
EDGE_PATH = ARTICLE_DIR / "data" / "biological_network_edges.csv"
STATE_PATH = ARTICLE_DIR / "data" / "diffusion_initial_state.csv"


def main() -> None:
    edges = pd.read_csv(EDGE_PATH)
    initial = pd.read_csv(STATE_PATH)

    nodes, adjacency = adjacency_matrix(edges)

    state_map = dict(zip(initial["node"], initial["initial_state"]))
    initial_state = np.array([state_map.get(node, 0.0) for node in nodes], dtype=float)

    history = diffuse_on_network(
        adjacency=adjacency,
        initial_state=initial_state,
        alpha=0.08,
        decay=0.04,
        steps=25,
    )

    trajectory = pd.DataFrame(history, columns=nodes)
    trajectory.insert(0, "step", range(len(trajectory)))

    final = trajectory.tail(1).T.reset_index()
    final.columns = ["node", "final_state"]
    final = final[final["node"] != "step"]

    print(trajectory.tail(5).round(5).to_string(index=False))
    print(final.sort_values("final_state", ascending=False).round(5).to_string(index=False))


if __name__ == "__main__":
    main()
