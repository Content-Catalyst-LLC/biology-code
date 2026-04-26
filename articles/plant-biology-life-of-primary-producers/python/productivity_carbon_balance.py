"""
Productivity and carbon-balance comparison.

Run:
    python python/productivity_carbon_balance.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
SITES_PATH = ARTICLE_DIR / "data" / "productivity_sites.csv"


def main() -> None:
    """Calculate NPP and NEP across sites."""

    sites = pd.read_csv(SITES_PATH)

    sites["NPP"] = sites["GPP"] - sites["Ra"]
    sites["NEP"] = sites["GPP"] - (sites["Ra"] + sites["Rh"])

    sites["carbon_balance_class"] = sites["NEP"].apply(
        lambda nep: "strong_net_sink"
        if nep > 250
        else "weak_net_sink"
        if nep > 0
        else "net_source_or_unstable"
    )

    print(sites.to_string(index=False))


if __name__ == "__main__":
    main()
