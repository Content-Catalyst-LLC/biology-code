"""
Generate a model provenance manifest with checksums.

Run from the article directory:
    python python/04_model_provenance_manifest.py
"""

from pathlib import Path

import pandas as pd

from ml_life_sciences_core import safe_sha256


ARTICLE_DIR = Path(__file__).resolve().parents[1]
INPUT_PATH = ARTICLE_DIR / "data" / "model_run_manifest.csv"
OUTPUT_PATH = ARTICLE_DIR / "outputs" / "tables" / "model_provenance_manifest.csv"


def hash_input_artifacts(value: str) -> str:
    hashes = []

    for artifact in str(value).split(";"):
        data_path = ARTICLE_DIR / "data" / artifact
        output_path = ARTICLE_DIR / artifact
        if data_path.exists():
            path = data_path
        else:
            path = output_path
        hashes.append(f"{artifact}:{safe_sha256(path)}")

    return "|".join(hashes)


def main() -> None:
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)

    manifest = pd.read_csv(INPUT_PATH)
    manifest["input_sha256"] = manifest["input_data"].apply(hash_input_artifacts)
    manifest["output_sha256"] = manifest["output_artifact"].apply(lambda artifact: safe_sha256(ARTICLE_DIR / artifact))

    manifest.to_csv(OUTPUT_PATH, index=False)

    print(manifest.to_string(index=False))
    print(f"Saved: {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
