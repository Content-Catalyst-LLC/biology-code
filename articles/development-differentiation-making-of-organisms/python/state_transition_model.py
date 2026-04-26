"""
Markov-style developmental state transition model.

Run:
    python python/state_transition_model.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
STATE_PATH = ARTICLE_DIR / "data" / "state_transition_matrix.csv"


def main() -> None:
    """Simulate developmental state composition through transition steps."""

    matrix_df = pd.read_csv(STATE_PATH)
    states = matrix_df["state"].tolist()
    P = matrix_df[states].to_numpy(dtype=float)

    x0 = np.array([0.90, 0.08, 0.01, 0.01], dtype=float)

    trajectory = [x0]
    x = x0.copy()

    for _ in range(20):
        x = x @ P
        trajectory.append(x.copy())

    traj_df = pd.DataFrame(trajectory, columns=states)
    traj_df["step"] = range(len(traj_df))

    print(traj_df.round(4).to_string(index=False))


if __name__ == "__main__":
    main()
