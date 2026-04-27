"""
Provenance manifest workflow.

Run:
    python python/provenance_manifest.py
"""

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
DATA_PATH = ARTICLE_DIR / "data" / "provenance_steps.csv"


def main() -> None:
    provenance = pd.read_csv(DATA_PATH)

    summary = pd.DataFrame(
        {
            "n_steps": [len(provenance)],
            "n_unique_inputs": [provenance["input_artifact"].nunique()],
            "n_unique_outputs": [provenance["output_artifact"].nunique()],
            "operations": [", ".join(provenance["operation"].tolist())],
        }
    )

    print(provenance.to_string(index=False))
    print(summary.to_string(index=False))


if __name__ == "__main__":
    main()
