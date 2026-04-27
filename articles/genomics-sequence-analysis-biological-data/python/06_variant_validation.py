"""
Validate compact variant table and calculate variant allele frequency.

Run from article directory:
    python python/06_variant_validation.py
"""

from pathlib import Path

import pandas as pd

from genomics_sequence_core import validate_variants


ARTICLE_DIR = Path(__file__).resolve().parents[1]
VARIANT_PATH = ARTICLE_DIR / "data" / "variants.csv"
OUTPUT_PATH = ARTICLE_DIR / "outputs" / "tables" / "variant_validation.csv"


def main() -> None:
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)

    variants = pd.read_csv(VARIANT_PATH)
    result = validate_variants(variants, minimum_depth=10)

    result.to_csv(OUTPUT_PATH, index=False)

    print(result.round(5).to_string(index=False))
    print(f"Saved: {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
