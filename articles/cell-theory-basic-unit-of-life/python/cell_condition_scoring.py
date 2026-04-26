"""
Cell-condition scoring workflow.

Run:
    python python/cell_condition_scoring.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
CONDITION_PATH = ARTICLE_DIR / "data" / "cell_condition_sites.csv"
IMAGING_PATH = ARTICLE_DIR / "data" / "imaging_features.csv"


def validate_unit_interval(df: pd.DataFrame, columns: list[str]) -> None:
    """Validate that specified columns are scaled between zero and one."""

    for col in columns:
        if ((df[col] < 0) | (df[col] > 1)).any():
            raise ValueError(f"{col} must be scaled between 0 and 1.")


def condition_class(score: float) -> str:
    """Classify cell-condition score."""

    if score >= 0.75:
        return "strong_cell_condition"
    if score >= 0.50:
        return "moderate_cell_condition"
    return "constrained_cell_condition"


def main() -> None:
    """Score cell conditions and summarize imaging features."""

    cells = pd.read_csv(CONDITION_PATH)

    score_columns = [
        "membrane_integrity",
        "metabolic_activity",
        "proliferation_capacity",
        "genomic_stability",
        "organelle_function",
        "stress_penalty",
    ]

    validate_unit_interval(cells, score_columns)

    cells["cell_condition_score"] = (
        0.18 * cells["membrane_integrity"]
        + 0.22 * cells["metabolic_activity"]
        + 0.18 * cells["proliferation_capacity"]
        + 0.17 * cells["genomic_stability"]
        + 0.15 * cells["organelle_function"]
        + 0.10 * (1 - cells["stress_penalty"])
    )

    cells["condition_class"] = cells["cell_condition_score"].apply(condition_class)

    imaging = pd.read_csv(IMAGING_PATH)

    imaging_summary = (
        imaging.groupby("condition")
        .agg(
            mean_area_um2=("area_um2", "mean"),
            mean_nuclear_area_um2=("nuclear_area_um2", "mean"),
            mean_intensity=("mean_intensity", "mean"),
            mean_roundness=("roundness", "mean"),
            n_cells=("cell_id", "count"),
        )
        .reset_index()
    )

    print(
        cells.sort_values("cell_condition_score", ascending=False)
        .round(3)
        .to_string(index=False)
    )
    print(imaging_summary.round(3).to_string(index=False))


if __name__ == "__main__":
    main()
