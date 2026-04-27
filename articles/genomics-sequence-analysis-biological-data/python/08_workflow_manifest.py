"""
Create workflow manifest with artifact checksums.

Run from article directory:
    python python/08_workflow_manifest.py
"""

from pathlib import Path

import pandas as pd

from genomics_sequence_core import safe_sha256


ARTICLE_DIR = Path(__file__).resolve().parents[1]
WORKFLOW_PATH = ARTICLE_DIR / "data" / "workflow_steps.csv"
OUTPUT_PATH = ARTICLE_DIR / "outputs" / "tables" / "workflow_manifest.csv"


def hash_input_artifacts(value: str) -> str:
    hashes = []

    for artifact in str(value).split(";"):
        path = ARTICLE_DIR / "data" / artifact
        hashes.append(f"{artifact}:{safe_sha256(path)}")

    return "|".join(hashes)


def main() -> None:
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)

    workflow = pd.read_csv(WORKFLOW_PATH)
    workflow["input_sha256"] = workflow["input_artifact"].apply(hash_input_artifacts)
    workflow["output_sha256"] = workflow["output_artifact"].apply(lambda artifact: safe_sha256(ARTICLE_DIR / artifact))

    workflow.to_csv(OUTPUT_PATH, index=False)

    print(workflow.to_string(index=False))
    print(f"Saved: {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
