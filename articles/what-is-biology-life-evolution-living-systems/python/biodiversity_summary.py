"""
Biodiversity summary workflow.

Run:
    python python/biodiversity_summary.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd

from biology_core import shannon_diversity


ARTICLE_DIR = Path(__file__).resolve().parents[1]
BIODIV_PATH = ARTICLE_DIR / "data" / "biodiversity_counts.csv"


def main() -> None:
    counts = pd.read_csv(BIODIV_PATH).set_index("site")
    taxon_cols = list(counts.columns)

    rows = []

    for site, row in counts.iterrows():
        rows.append(
            {
                "site": site,
                "richness": int((row[taxon_cols] > 0).sum()),
                "total_abundance": float(row[taxon_cols].sum()),
                "shannon_diversity": shannon_diversity(row[taxon_cols]),
            }
        )

    print(pd.DataFrame(rows).round(4).to_string(index=False))


if __name__ == "__main__":
    main()
