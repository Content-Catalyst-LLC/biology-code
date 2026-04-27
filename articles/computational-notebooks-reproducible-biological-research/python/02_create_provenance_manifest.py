"""
Create a provenance manifest for notebook input artifacts.

Run from article directory:
    python python/02_create_provenance_manifest.py
"""

from pathlib import Path

import pandas as pd

from notebook_reproducibility_core import safe_sha256


ARTICLE_DIR = Path(__file__).resolve().parents[1]
DATA_DIR = ARTICLE_DIR / "data"
OUTPUT_PATH = ARTICLE_DIR / "outputs" / "manifests" / "provenance_manifest.csv"


def main() -> None:
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)

    rows = []
    for path in sorted(DATA_DIR.glob("*.csv")):
        rows.append(
            {
                "artifact": path.name,
                "artifact_type": "input_data",
                "relative_path": str(path.relative_to(ARTICLE_DIR)),
                "sha256": safe_sha256(path),
                "note": "Synthetic biological notebook workflow artifact",
            }
        )

    manifest = pd.DataFrame(rows)
    manifest.to_csv(OUTPUT_PATH, index=False)

    print(manifest.to_string(index=False))
    print(f"Saved: {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
