"""
Create workflow manifest with artifact checksums.

Run from article directory:
    python python/06_workflow_manifest.py
"""

from pathlib import Path

import pandas as pd

from biology_workflow_core import sha256_file


ARTICLE_DIR = Path(__file__).resolve().parents[1]
WORKFLOW_PATH = ARTICLE_DIR / "data" / "workflow_steps.csv"
OUTPUT_PATH = ARTICLE_DIR / "outputs" / "tables" / "workflow_manifest.csv"


def safe_hash(relative_path: str) -> str:
    path = ARTICLE_DIR / relative_path
    if path.exists() and path.is_file():
        return sha256_file(path)
    return "not_available"


def main() -> None:
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)

    workflow = pd.read_csv(WORKFLOW_PATH)
    workflow["input_sha256"] = workflow["input_artifact"].apply(lambda value: safe_hash(f"data/{value}"))
    workflow["output_sha256"] = workflow["output_artifact"].apply(safe_hash)

    workflow.to_csv(OUTPUT_PATH, index=False)

    print(workflow.to_string(index=False))
    print(f"Saved: {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
