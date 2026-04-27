"""
Metadata and data dictionary summary.

Run:
    python python/metadata_manifest.py
"""

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]


def main() -> None:
    dictionary = pd.read_csv(ARTICLE_DIR / "data" / "data_dictionary.csv")

    summary = pd.DataFrame(
        {
            "n_variables": [len(dictionary)],
            "n_required": [(dictionary["required"].astype(str).str.lower() == "true").sum()],
            "n_with_units": [dictionary["unit"].notna().sum()],
            "n_with_allowed_values": [dictionary["allowed_values"].notna().sum()],
        }
    )

    print(summary.to_string(index=False))
    print(dictionary.to_string(index=False))


if __name__ == "__main__":
    main()
