"""
Ecological condition screening.

This script combines community composition, Bray-Curtis turnover, ecosystem
process indicators, Shannon diversity, and a compact ecological-condition score.

Run:
    python python/ecological_condition_screening.py
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
    """Run ecological condition screening and ordination."""

    community = pd.read_csv(COMMUNITY_PATH).set_index("site")
    indicators = pd.read_csv(INDICATORS_PATH).set_index("site")

    relative_abundance = community.div(community.sum(axis=1), axis=0)
    safe_relative_abundance = relative_abundance.replace(0, np.nan)

    shannon = -(
        safe_relative_abundance * np.log(safe_relative_abundance)
    ).sum(axis=1).fillna(0)

    bray_curtis = squareform(pdist(community.values, metric="braycurtis"))
    bray_curtis_df = pd.DataFrame(
        bray_curtis,
        index=community.index,
        columns=community.index,
    )

    condition = pd.DataFrame(index=community.index)
    condition["shannon"] = shannon
    condition["mean_turnover"] = bray_curtis_df.mean(axis=1)
    condition = condition.join(indicators)

    condition["ecological_condition"] = (
        0.20 * (condition["shannon"] / condition["shannon"].max())
        + 0.20 * condition["productivity"]
        + 0.20 * condition["nutrient_retention"]
        + 0.15 * condition["connectivity"]
        - 0.15 * condition["mean_turnover"]
        - 0.20 * condition["disturbance_pressure"]
    )

    scaled = StandardScaler().fit_transform(condition)
    ordination = pd.DataFrame(
        PCA(n_components=2).fit_transform(scaled),
        index=condition.index,
        columns=["PC1", "PC2"],
    )

    print("Community turnover matrix:")
    print(bray_curtis_df.round(3).to_string())

    print("\nEcological condition summary:")
    print(condition.round(3).to_string())

    print("\nOrdination scores:")
    print(ordination.round(3).to_string())


if __name__ == "__main__":
    main()
