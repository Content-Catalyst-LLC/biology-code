"""
Community turnover and ecosystem reorganization risk.

This script combines community composition, Bray-Curtis turnover, ecosystem
process indicators, and a compact reorganization-risk score.

Run:
    python python/community_turnover_risk.py
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
INDICATORS_PATH = ARTICLE_DIR / "data" / "ecosystem_indicators.csv"


def main() -> None:
    """Run community turnover and ecosystem risk screening."""

    community = pd.read_csv(COMMUNITY_PATH).set_index("site")
    indicators = pd.read_csv(INDICATORS_PATH).set_index("site")

    relative_abundance = community.div(community.sum(axis=1), axis=0)
    safe_relative_abundance = relative_abundance.replace(0, np.nan)

    shannon = -(
        safe_relative_abundance * np.log(safe_relative_abundance)
    ).sum(axis=1).fillna(0)

    richness = (community > 0).sum(axis=1)

    bray_curtis = squareform(pdist(community.values, metric="braycurtis"))
    bray_curtis_df = pd.DataFrame(
        bray_curtis,
        index=community.index,
        columns=community.index,
    )

    risk = pd.DataFrame(index=community.index)
    risk["richness"] = richness
    risk["shannon"] = shannon
    risk["mean_turnover"] = bray_curtis_df.mean(axis=1)
    risk = risk.join(indicators)

    risk["reorganization_risk"] = (
        0.20 * (risk["mean_turnover"] / risk["mean_turnover"].max())
        + 0.25 * risk["disturbance_pressure"]
        + 0.20 * (1 - risk["connectivity"])
        - 0.15 * (risk["productivity"] / risk["productivity"].max())
        - 0.20 * (risk["nutrient_retention"] / risk["nutrient_retention"].max())
    )

    scaled = StandardScaler().fit_transform(
        risk[
            [
                "richness",
                "shannon",
                "mean_turnover",
                "productivity",
                "nutrient_retention",
                "disturbance_pressure",
                "connectivity",
            ]
        ]
    )

    ordination = pd.DataFrame(
        PCA(n_components=2).fit_transform(scaled),
        index=risk.index,
        columns=["PC1", "PC2"],
    )

    print("Diversity and ecosystem risk summary:")
    print(risk.round(3).to_string())

    print("\nBray-Curtis turnover matrix:")
    print(bray_curtis_df.round(3).to_string())

    print("\nOrdination scores:")
    print(ordination.round(3).to_string())


if __name__ == "__main__":
    main()
