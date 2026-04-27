"""
Checksum manifest workflow.

Run:
    python python/checksum_manifest.py
"""

from pathlib import Path

import pandas as pd

from reproducibility_core import sha256_file


ARTICLE_DIR = Path(__file__).resolve().parents[1]
DATA_DIR = ARTICLE_DIR / "data"


def main() -> None:
    rows = []

    for path in sorted(DATA_DIR.glob("*.csv")):
        rows.append(
            {
                "artifact_name": path.name,
                "relative_path": str(path.relative_to(ARTICLE_DIR)),
                "sha256": sha256_file(path),
            }
        )

    manifest = pd.DataFrame(rows)

    print(manifest.to_string(index=False))


if __name__ == "__main__":
    main()
