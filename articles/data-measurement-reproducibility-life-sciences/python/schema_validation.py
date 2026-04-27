"""
Schema validation workflow.

Run:
    python python/schema_validation.py
"""

from pathlib import Path

import pandas as pd

from reproducibility_core import validate_qc_flags, validate_required_columns


ARTICLE_DIR = Path(__file__).resolve().parents[1]
DATA_PATH = ARTICLE_DIR / "data" / "measurements.csv"
DICTIONARY_PATH = ARTICLE_DIR / "data" / "data_dictionary.csv"


def main() -> None:
    data = pd.read_csv(DATA_PATH)
    dictionary = pd.read_csv(DICTIONARY_PATH)

    validations = pd.concat(
        [
            validate_required_columns(data, dictionary),
            validate_qc_flags(data),
        ],
        ignore_index=True,
    )

    print(validations.to_string(index=False))


if __name__ == "__main__":
    main()
