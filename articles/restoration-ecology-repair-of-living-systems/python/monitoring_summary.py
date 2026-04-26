"""
Monitoring Indicator Summary

This script creates a compact monitoring framework for restoration ecology.
"""

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]


def main() -> None:
    indicators = pd.read_csv(ARTICLE_DIR / "data" / "monitoring_indicators.csv")

    summary = (
        indicators.groupby("domain", as_index=False)
        .agg(
            indicator_count=("indicator", "count"),
            indicators=("indicator", lambda values: "; ".join(values)),
        )
        .sort_values("domain")
    )

    summary.to_csv(
        ARTICLE_DIR / "data" / "computed_monitoring_indicator_summary.csv",
        index=False,
    )

    print("Monitoring domains:")
    print(summary.to_string(index=False))


if __name__ == "__main__":
    main()
