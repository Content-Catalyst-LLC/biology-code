"""
Workflow audit summary.

Run:
    python python/workflow_audit.py
"""

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]


def main() -> None:
    artifacts = pd.read_csv(ARTICLE_DIR / "data" / "artifact_manifest.csv")
    provenance = pd.read_csv(ARTICLE_DIR / "data" / "provenance_steps.csv")

    artifact_roles = (
        artifacts.groupby("artifact_role")
        .size()
        .reset_index(name="n_artifacts")
        .sort_values("n_artifacts", ascending=False)
    )

    operations = (
        provenance.groupby("operation")
        .size()
        .reset_index(name="n_steps")
        .sort_values("n_steps", ascending=False)
    )

    print(artifact_roles.to_string(index=False))
    print(operations.to_string(index=False))


if __name__ == "__main__":
    main()
