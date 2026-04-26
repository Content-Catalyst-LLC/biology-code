"""
Markov-style cell-state transition workflow.

Run:
    python python/cell_state_transitions.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
MATRIX_PATH = ARTICLE_DIR / "data" / "cell_state_transition_matrix.csv"


def main() -> None:
    """Simulate a cell-state distribution through transition steps."""

    matrix_df = pd.read_csv(MATRIX_PATH)
    states = matrix_df["state"].tolist()
    P = matrix_df[states].to_numpy(dtype=float)

    x0 = np.array([0.85, 0.10, 0.05], dtype=float)

    trajectory = [x0]
    x = x0.copy()

    for _ in range(15):
        x = x @ P
        trajectory.append(x.copy())

    traj_df = pd.DataFrame(trajectory, columns=states)
    traj_df["step"] = range(len(traj_df))

    print(traj_df.round(4).to_string(index=False))


if __name__ == "__main__":
    main()
