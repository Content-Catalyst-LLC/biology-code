"""
Genomics count normalization cross-check.

Run:
    python python/genomics_summary.py
"""

from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]


def main() -> None:
    counts_table = pd.read_csv(ARTICLE_DIR / "data" / "genomics_counts.csv")
    metadata = pd.read_csv(ARTICLE_DIR / "data" / "genomics_metadata.csv")

    counts = counts_table.set_index("gene_id")
    counts = counts[metadata["sample_id"]]

    library_sizes = counts.sum(axis=0)
    cpm = counts.divide(library_sizes, axis=1) * 1_000_000

    control = metadata.loc[metadata["condition"] == "control", "sample_id"]
    treated = metadata.loc[metadata["condition"] == "treated", "sample_id"]

    summary = pd.DataFrame(
        {
            "gene_id": counts.index,
            "raw_count_total": counts.sum(axis=1),
            "mean_cpm_control": cpm[control].mean(axis=1),
            "mean_cpm_treated": cpm[treated].mean(axis=1),
        }
    )

    summary["log2_fold_change"] = np.log2(
        (summary["mean_cpm_treated"] + 1) /
        (summary["mean_cpm_control"] + 1)
    )

    print(summary.round(5).to_string(index=False))


if __name__ == "__main__":
    main()
