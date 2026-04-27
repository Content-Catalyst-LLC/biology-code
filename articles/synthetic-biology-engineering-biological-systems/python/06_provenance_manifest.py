"""
Create a provenance manifest for synthetic biology workflows.

Run from article directory:
    python python/06_provenance_manifest.py
"""

from pathlib import Path
import pandas as pd

from synthetic_biology_core import safe_sha256


ARTICLE_DIR = Path(__file__).resolve().parents[1]
WORKFLOW_PATH = ARTICLE_DIR / "data" / "workflow_manifest.csv"
OUTPUT_PATH = ARTICLE_DIR / "outputs" / "manifests" / "provenance_manifest.csv"


def hash_artifacts(value: str) -> str:
    hashes = []
    for artifact in str(value).split(";"):
        data_path = ARTICLE_DIR / "data" / artifact
        output_path = ARTICLE_DIR / artifact
        path = data_path if data_path.exists() else output_path
        hashes.append(f"{artifact}:{safe_sha256(path)}")
    return "|".join(hashes)


def main() -> None:
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)

    workflow = pd.read_csv(WORKFLOW_PATH)
    workflow["input_sha256"] = workflow["input_artifact"].apply(hash_artifacts)
    workflow["output_sha256"] = workflow["output_artifact"].apply(lambda artifact: safe_sha256(ARTICLE_DIR / artifact))

    workflow.to_csv(OUTPUT_PATH, index=False)

    print(workflow.to_string(index=False))
    print(f"Saved: {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
