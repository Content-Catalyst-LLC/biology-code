"""
Biodiversity-index workflow.

Run:
    python python/biodiversity_indices.py
"""

from __future__ import annotations

from itertools import product
from pathlib import Path

import pandas as pd

from taxonomy_core import bray_curtis, shannon_diversity


ARTICLE_DIR = Path(__file__).resolve().parents[1]
COUNTS_PATH = ARTICLE_DIR / "data" / "community_counts.csv"


def main() -> None:
    counts = pd.read_csv(COUNTS_PATH).set_index("site")
    taxon_cols = list(counts.columns)

    shannon_rows = []

    for site, row in counts.iterrows():
        shannon_rows.append(
            {
                "site": site,
                "total_abundance": row[taxon_cols].sum(),
                "richness": int((row[taxon_cols] > 0).sum()),
                "shannon_diversity": shannon_diversity(row[taxon_cols]),
            }
        )

    sites = list(counts.index)
    bc = pd.DataFrame(index=sites, columns=sites, dtype=float)

    for s1, s2 in product(sites, sites):
        bc.loc[s1, s2] = bray_curtis(counts.loc[s1, taxon_cols], counts.loc[s2, taxon_cols])

    print(pd.DataFrame(shannon_rows).round(4).to_string(index=False))
    print("\nBray-Curtis dissimilarity matrix:")
    print(bc.round(4).to_string())


if __name__ == "__main__":
    main()
