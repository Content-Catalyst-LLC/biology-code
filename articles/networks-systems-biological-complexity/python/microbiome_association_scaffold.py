"""
Microbiome association network scaffold.

Run:
    python python/microbiome_association_scaffold.py
"""

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
DATA_PATH = ARTICLE_DIR / "data" / "microbiome_associations.csv"


def main() -> None:
    associations = pd.read_csv(DATA_PATH)

    taxa = sorted(set(associations["taxon_a"]).union(associations["taxon_b"]))

    rows = []

    for taxon in taxa:
        subset = associations[(associations["taxon_a"] == taxon) | (associations["taxon_b"] == taxon)]
        rows.append(
            {
                "taxon": taxon,
                "n_associations": len(subset),
                "mean_absolute_association": subset["association_strength"].abs().mean(),
                "positive_associations": (subset["association_strength"] > 0).sum(),
                "negative_associations": (subset["association_strength"] < 0).sum(),
            }
        )

    summary = pd.DataFrame(rows).sort_values(["n_associations", "mean_absolute_association"], ascending=False)

    module_summary = (
        associations.groupby("module")
        .agg(
            n_associations=("taxon_a", "count"),
            mean_association=("association_strength", "mean"),
            mean_absolute_association=("association_strength", lambda x: x.abs().mean()),
        )
        .reset_index()
        .sort_values("n_associations", ascending=False)
    )

    print(summary.round(5).to_string(index=False))
    print(module_summary.round(5).to_string(index=False))


if __name__ == "__main__":
    main()
