"""
Stage-structured reproductive projection.

This script projects a simple life cycle with juveniles, subadults, and adults.
It estimates dominant eigenvalue growth, stable stage distribution, and a
perturbation to adult survival.

Run:
    python python/stage_reproductive_projection.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
MATRIX_PATH = ARTICLE_DIR / "data" / "stage_matrix.csv"
VECTOR_PATH = ARTICLE_DIR / "data" / "initial_stage_vector.csv"


def load_projection_matrix() -> tuple[list[str], np.ndarray]:
    """Load projection matrix from CSV."""

    matrix_df = pd.read_csv(MATRIX_PATH)
    stages = matrix_df["stage"].tolist()
    projection_matrix = matrix_df.drop(columns=["stage"]).to_numpy(dtype=float)
    return stages, projection_matrix


def project_stages(
    projection_matrix: np.ndarray,
    initial_stage_vector: np.ndarray,
    time_steps: int,
) -> pd.DataFrame:
    """Project stage abundances through time."""

    trajectory = np.zeros((time_steps + 1, len(initial_stage_vector)))
    trajectory[0, :] = initial_stage_vector

    for time_step in range(time_steps):
        trajectory[time_step + 1, :] = projection_matrix @ trajectory[time_step, :]

    return pd.DataFrame(trajectory)


def dominant_growth_and_stage_distribution(
    projection_matrix: np.ndarray,
) -> tuple[float, np.ndarray]:
    """Return dominant eigenvalue and normalized stable stage distribution."""

    eigenvalues, eigenvectors = np.linalg.eig(projection_matrix)
    dominant_index = np.argmax(np.real(eigenvalues))

    lambda_dominant = float(np.real(eigenvalues[dominant_index]))
    stable_stage = np.real(eigenvectors[:, dominant_index])
    stable_stage = stable_stage / stable_stage.sum()

    return lambda_dominant, stable_stage


def main() -> None:
    """Run stage projection and perturbation analysis."""

    stages, projection_matrix = load_projection_matrix()
    initial_stage_vector = pd.read_csv(VECTOR_PATH)["count"].to_numpy(dtype=float)

    trajectory_df = project_stages(
        projection_matrix=projection_matrix,
        initial_stage_vector=initial_stage_vector,
        time_steps=20,
    )

    trajectory_df.columns = stages
    trajectory_df["total"] = trajectory_df.sum(axis=1)

    lambda_dominant, stable_stage = dominant_growth_and_stage_distribution(
        projection_matrix
    )

    perturbed = projection_matrix.copy()
    adult_index = stages.index("adult")
    perturbed[adult_index, adult_index] *= 0.90

    lambda_perturbed, _ = dominant_growth_and_stage_distribution(perturbed)

    print("Stage trajectory:")
    print(trajectory_df.round(2).to_string())

    print("\nDominant lambda:", round(lambda_dominant, 4))
    print(
        "Stable stage distribution:",
        dict(zip(stages, np.round(stable_stage, 4))),
    )
    print(
        "Lambda after 10 percent adult survival reduction:",
        round(lambda_perturbed, 4),
    )
    print("Change in lambda:", round(lambda_perturbed - lambda_dominant, 4))


if __name__ == "__main__":
    main()
