"""
Stage-structured population projection and sensitivity prototype.

This script projects a simple 3-stage population using a matrix model and
evaluates sensitivity to a decline in adult survival.

Run:
    python python/stage_structured_projection.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
MATRIX_PATH = ARTICLE_DIR / "data" / "stage_matrix.csv"
VECTOR_PATH = ARTICLE_DIR / "data" / "initial_stage_vector.csv"


def load_projection_matrix() -> tuple[list[str], np.ndarray]:
    """Load a projection matrix from CSV."""

    matrix_df = pd.read_csv(MATRIX_PATH)
    stages = matrix_df["stage"].tolist()
    matrix = matrix_df.drop(columns=["stage"]).to_numpy(dtype=float)
    return stages, matrix


def main() -> None:
    """Project stage-structured population and print sensitivity results."""

    stages, projection_matrix = load_projection_matrix()

    vector_df = pd.read_csv(VECTOR_PATH)
    initial_stage_vector = vector_df["count"].to_numpy(dtype=float)

    time_steps = 20
    trajectory = np.zeros((time_steps + 1, len(initial_stage_vector)))
    trajectory[0, :] = initial_stage_vector

    for time_step in range(time_steps):
        trajectory[time_step + 1, :] = (
            projection_matrix @ trajectory[time_step, :]
        )

    trajectory_df = pd.DataFrame(trajectory, columns=stages)
    trajectory_df["total_population"] = trajectory_df.sum(axis=1)

    eigenvalues, eigenvectors = np.linalg.eig(projection_matrix)
    dominant_index = np.argmax(np.real(eigenvalues))
    lambda_dominant = np.real(eigenvalues[dominant_index])

    stable_stage = np.real(eigenvectors[:, dominant_index])
    stable_stage = stable_stage / stable_stage.sum()

    projection_matrix_perturbed = projection_matrix.copy()
    projection_matrix_perturbed[2, 2] *= 0.90

    eigenvalues_perturbed, _ = np.linalg.eig(projection_matrix_perturbed)
    lambda_perturbed = np.max(np.real(eigenvalues_perturbed))

    print("Trajectory:")
    print(trajectory_df.round(2).to_string())

    print("\nDominant lambda:", round(lambda_dominant, 4))

    print(
        "Stable stage distribution:",
        dict(zip(stages, np.round(stable_stage, 4))),
    )

    print(
        "Lambda after 10 percent adult survival decline:",
        round(lambda_perturbed, 4),
    )

    print(
        "Change in lambda:",
        round(lambda_perturbed - lambda_dominant, 4),
    )


if __name__ == "__main__":
    main()
