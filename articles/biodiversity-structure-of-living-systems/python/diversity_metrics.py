"""
Biodiversity metrics workflow.

This script calculates richness, Shannon diversity, Simpson diversity,
Hill numbers, Bray-Curtis turnover, community-weighted mean traits,
and PCA ordination scores from a compact site-by-species matrix.

Run:
    python python/diversity_metrics.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd
from scipy.spatial.distance import pdist, squareform
from sklearn.decomposition import PCA
from sklearn.preprocessing import StandardScaler


ARTICLE_DIR = Path(__file__).resolve().parents[1]
COMMUNITY_PATH = ARTICLE_DIR / "data" / "community_matrix.csv"
TRAITS_PATH = ARTICLE_DIR / "data" / "species_traits.csv"


def calculate_diversity_metrics(community: pd.DataFrame) -> pd.DataFrame:
    """Calculate richness, Shannon, Simpson, and Hill numbers."""

    relative_abundance = community.div(community.sum(axis=1), axis=0)
    safe_relative_abundance = relative_abundance.replace(0, np.nan)

    shannon = -(
        safe_relative_abundance * np.log(safe_relative_abundance)
    ).sum(axis=1).fillna(0)

    simpson = 1 - (relative_abundance**2).sum(axis=1)
    hill_q1 = np.exp(shannon)
    hill_q2 = 1 / (relative_abundance**2).sum(axis=1)

    return pd.DataFrame(
        {
            "richness": (community > 0).sum(axis=1),
            "shannon": shannon,
            "simpson": simpson,
            "hill_q1": hill_q1,
            "hill_q2": hill_q2,
        }
    )


def main() -> None:
    """Run biodiversity metrics and print summary tables."""

    community_raw = pd.read_csv(COMMUNITY_PATH)
    community = community_raw.set_index("site")

    traits_raw = pd.read_csv(TRAITS_PATH)
    traits = traits_raw.set_index("species")[["body_size", "trophic_level", "dispersal"]]

    diversity_summary = calculate_diversity_metrics(community)
    print("Diversity metrics:")
    print(diversity_summary.round(3).to_string())

    bray_curtis = squareform(pdist(community.values, metric="braycurtis"))
    bray_curtis_df = pd.DataFrame(
        bray_curtis,
        index=community.index,
        columns=community.index,
    )
    print("\nBray-Curtis dissimilarity:")
    print(bray_curtis_df.round(3).to_string())

    relative_abundance = community.div(community.sum(axis=1), axis=0)
    community_weighted_means = relative_abundance.dot(traits)
    print("\nCommunity-weighted mean traits:")
    print(community_weighted_means.round(3).to_string())

    scaled_community = StandardScaler().fit_transform(community)
    scores = PCA(n_components=2).fit_transform(scaled_community)

    ordination = pd.DataFrame(scores, index=community.index, columns=["PC1", "PC2"])
    print("\nPCA ordination scores:")
    print(ordination.round(3).to_string())


if __name__ == "__main__":
    main()
